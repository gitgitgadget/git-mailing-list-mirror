From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCHv3 0/2] Teach --recursive to submodule sync
Date: Sun, 28 Oct 2012 22:02:46 +0100
Message-ID: <508D9D76.5090501@web.de>
References: <508AE3E9.6000304@web.de> <1351280683-8402-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, phil.hord@gmail.com, Jeff King <peff@peff.net>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 22:03:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSa0d-0000Un-DP
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 22:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738Ab2J1VCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 17:02:51 -0400
Received: from mout.web.de ([212.227.17.12]:57103 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755672Ab2J1VCu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 17:02:50 -0400
Received: from [192.168.178.41] ([91.3.156.115]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MIeUW-1TQN5D0OqG-002ttO; Sun, 28 Oct 2012 22:02:47
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <1351280683-8402-1-git-send-email-hordp@cisco.com>
X-Enigmail-Version: 1.4.5
X-Provags-ID: V02:K0:wAr8PH97nfu6r1qaVn++pYoK6aWvY+8HiAD4KK/19x3
 92FRHxDFgPWMnKASoaMoCdC2LTsE1oKTlW8mbCJ8Q54bieU9Yd
 Z/eqDPXoRfwYa4OPZV7jJ1RA7tejqfUBvW2pNCh3/tf7fC1F8z
 lwIXcQe1qOicuayFTBRWnWYCeWLFYDuKHXFOKSTYO/NDo8k8+P
 9QWcmhNVvpTc9FNFauF9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208565>

Am 26.10.2012 21:44, schrieb Phil Hord:
> [PATCHv3 1/2] Teach --recursive to submodule sync
> 
> Now with less noise and no redundant flags passed to the recursive call.
> 
> 
> [PATCHv3 2/2] Add tests for submodule sync --recursive
> 
> The test remains unchanged.

Both are looking good.

Acked-By: Jens Lehmann <Jens.Lehmann@web.de>
