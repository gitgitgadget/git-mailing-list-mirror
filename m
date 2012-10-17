From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git submodule sync --recursive
Date: Wed, 17 Oct 2012 20:26:52 +0200
Message-ID: <507EF86C.4050807@web.de>
References: <CABURp0obPcS=KZJ4xaVouHBS_O+OuWGYxYwSU9wwnQrL5Huwzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 20:27:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOYKm-0004AA-3P
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 20:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120Ab2JQS1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 14:27:00 -0400
Received: from mout.web.de ([212.227.15.3]:56358 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757606Ab2JQS07 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 14:26:59 -0400
Received: from [192.168.178.41] ([79.193.95.70]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MddJY-1SzADc2EHM-00PrWt; Wed, 17 Oct 2012 20:26:57
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <CABURp0obPcS=KZJ4xaVouHBS_O+OuWGYxYwSU9wwnQrL5Huwzg@mail.gmail.com>
X-Provags-ID: V02:K0:v0bNQ3KexWc0z5F+7UyGAgRVB/VmO07FXDzcl6/hWsQ
 rGS8+CDNRwe/rj0vTq36/ZNh7z9hsgCCSmwdH8UOGr4zcy6DNN
 fSZcSBs1EaiBvNZdcU0Vv6+8IvTb+LSn7nxqBo0J0/2ICj2CU0
 do0BX2rNfyeZzSSV6Z533OxMbihN7HDhhNKFPBP56RrrJnUhrM
 ih2r+IZMpUW7rFZjJNGNA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207932>

Am 17.10.2012 01:20, schrieb Phil Hord:
> I noticed that this is not supported:
> 
>     git submodule sync --recursive
> 
> 
> I do not see any discussion in the relevant commits about why it
> cannot or should not be supported.  Is it just an itch no one has
> scratched?

I can't remember any discussions about that either, but can't
think of a reason why we shouldn't support that.
