From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] diff-tree: do not show the sha1 of the given head with
 --quiet
Date: Wed, 22 Jul 2015 13:42:41 +0200
Organization: gmx
Message-ID: <692dbd9ee45e10a17587970eaa2a1c4e@www.dscho.org>
References: <0000014eb518dc87-a69705c4-31e7-4983-99a8-f780a743aeac-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 13:42:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHsQL-0003NG-Jp
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 13:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934126AbbGVLmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 07:42:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:56723 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934025AbbGVLmp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 07:42:45 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MhRUQ-1ZdPhz43l4-00Mcc7; Wed, 22 Jul 2015 13:42:42
 +0200
In-Reply-To: <0000014eb518dc87-a69705c4-31e7-4983-99a8-f780a743aeac-000000@eu-west-1.amazonses.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:k5ULzx8H0znP2OJ9ZI4fZD07vVKwQ/5Tt6i5OyZajzDNMuHLxd9
 xndzvBUga6VlcmSz5V+8nRsSS+gfbqPp6ACcR8JLOb49rfi0hwhI9ZtT3gFJjXuqLidPB5C
 hyEWSe5fIXgWbnZDWk5rUMzj0wo9mgpANRBxN3IqnUnkMqSwuxwbbV46PSPO7CSvXs/D+Qk
 +i8SGSHFCz+XXFF/iCnsg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oYtxaf5YJ7U=:IS3FmG74yFzKoYF98eRq1T
 kPFA/gJk+66i0W0j/gIr2ef8toDFTlhMZfuMRYdYNe1RIpi5zrd/woscEG5TJAKTsdM6LEskv
 7+mQOHASntDM++uGuj5J8QTcdvQ2sPkYKLxRi32WoJizHmrQmGWoLHl6OabXl5vrRSaJ7THhz
 bR9mYua3Z+9oi7nD6Do4wDh2ZZBYKvLHB+8+8sGc1TJTjkGZq/0u6eRSIF8UfagSh7jjzELgV
 yHbqCjp+UFxt5qg4CrQEXf2V5wjWJYpQbs2oXosq0+qz6bRAfd1L9HAwNFtkirx1AaP3yWGTJ
 lvZQ84x4LLm+1+9/iSJ/8aB01aE2mac1YPz4/YccTki/PgJ89kV9uvD+QtX/FKEvIRG0VBHdO
 7w8sO8EhljpBvAW6sOHUg1IyaaCBitS+MjStt5zjGP6wuM2oySVr774flAHQLxAStD9f/2shb
 c+nt1e1dym0RIeig+9ksNTe+XneN7rXSgsRZCFuP8i/gnjIyaeoS4a3bBowYiRdvW3Z32B+9E
 oxDOYboCDNZwchuHFOAP4ihGHfnCw7sv0IWzPVpAR5/1wtTI2z6pP+fH1lwlmlaxbLr4kEg84
 X99MK/mFQSzw7YNmdY9seopvFXJ56ksYRajnT1jNGUyoohk0JVHU4f5u+CdmNOLLsUZRZWjtc
 mofvR44dYGLJ2koQQmGDMjaWvWiLpU/e5DT5qk+hAtmTAGHYFK6rxcV0DxlO935XR1wc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274442>

On 2015-07-22 11:29, Sebastian Schuberth wrote:
> "--quite" is documented to "Disable all output of the program".

s/--quite/quiet/
