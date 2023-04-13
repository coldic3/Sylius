<?php

/*
 * This file is part of the Sylius package.
 *
 * (c) Paweł Jędrzejewski
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

declare(strict_types=1);

namespace spec\Sylius\Bundle\PayumBundle\HttpClient;

use Http\Client\HttpClient as BaseHttpClientInterface;
use Payum\Core\HttpClientInterface;
use PhpSpec\ObjectBehavior;
use Psr\Http\Message\RequestInterface;
use Psr\Http\Message\ResponseInterface;
use Sylius\Bundle\PayumBundle\HttpClient\HttpClient;

final class HttpClientSpec extends ObjectBehavior
{
    function let(BaseHttpClientInterface $client): void
    {
        $this->beConstructedWith($client);
    }

    function it_is_initializable(): void
    {
        $this->shouldHaveType(HttpClient::class);
    }

    function it_implements_http_client_interface(): void
    {
        $this->shouldImplement(HttpClientInterface::class);
    }

    function it_sends_a_request(
        BaseHttpClientInterface $client,
        RequestInterface $request,
        ResponseInterface $response
    ): void {
        $client->sendRequest($request)->willReturn($response);

        $this->send($request)->shouldReturn($response);
    }
}
