From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Starting on a microproject for GSoC
Date: Thu, 28 Jan 2016 09:22:40 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601280919240.2964@virtualbox>
References: <56A96380.3020308@moritzneeb.de> <CAH5451=u1MB=LJyBv+Z9e4Y5ncHktMw+oEycOWV1YXASaawMDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Moritz Neeb <lists@moritzneeb.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 09:22:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOhqu-0003hH-9T
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 09:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965925AbcA1IWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 03:22:47 -0500
Received: from mout.gmx.net ([212.227.17.21]:63572 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965914AbcA1IWo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 03:22:44 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MEo4s-1aIhJL2ALC-00FzZN; Thu, 28 Jan 2016 09:22:41
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAH5451=u1MB=LJyBv+Z9e4Y5ncHktMw+oEycOWV1YXASaawMDA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:F8ZsllCM4qqq+C+g/G4BsFLEhqgBQQkQNTGY/jZMaqOyB4mdozP
 X6yvrHHuZrTgRvcfdi2JMJ1fRVdDsQPcvzUzMw1aZn9RryKqt2jq07efDRtkolUnXR4f+c5
 sD1yE3poFMORkg7cQQ+YFa9xKIBfbixfjAgJ2Ujmyf+BI3MFM9gYGo9VXBaWZlXDJgTi9SG
 Zom8XcrgM2FtJWG+xC/PA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Rva6ppZE4Gk=:tuNCagt4WbJIJ1/HqacpCy
 0SRPtoPO6lajmnwy23ITJcssQEoSO8z8VAW80MRQI1N5vRBDXofvO72IvanxJEp72SDXNyw9e
 qFjGkcPwswtvSgtfAWHlFoIgQgoHP/lF5acXlJkhIXHuW+dPIh/nnKS8hiAQLG2IKGdlRj+vw
 bDHygzh4eJ9vxDHroJAQJ7zuJx3EVn5fj98WkqTpEEoe+Jg9faXaoOGInoybRZNUReQaPDqvE
 XSg6xdruaZ8I2tZCjDTjDpbod5XknJtMJVyBWXT3FQkRxSOWlEg/ak01UIt0xoBYqkyYgNrTW
 XZVXWWryvPBbb8XHsJSgP9KKLSyJNa2pEM+S9MudV6vK27l8XO5Gj4a/ncJ09SUarbyRKDK/9
 alYFZlGOxeJYb3VeN35I/VUT5/6S41S8r5mlYdeOLvBq7oL1gY0f210B0jyJbTwK5+WHEr78U
 OoighQ1cLhI6MtaaNJG/YhhQKkWAbWqRcersYVAqfriNZsUJEWh+J61b10O/NaXwocQZki4fS
 V8AhdGW7n/3NewGmf5TIY8GrRNVOEs/5V/VtDygACgmlrquClgFKg8ecUpOXL3/AYjiPEnHZL
 0nJtBbxpoHig3ydDt8EGVTxxpFHdUfgZn2XmexdPlET40rG7LTmiIfPpJ8ufVal6ZgA/mY9YR
 nWQTSyYw5dMj4q84yeIEmBFOf1p1yVHmC0mf4+ntYr4SdyPsLTv7T/IzfUU0ljEQTtOXmVlgD
 qFIk6vv3i8DZ77ZrTTB3MaeO53FBF/YVmQRsWl/PHpqpIU7QDYCCw3FObKTwR57cbfHlbzV2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284987>

Hi Moritz & Andrew,

On Thu, 28 Jan 2016, Andrew Ardill wrote:

> On 28 January 2016 at 11:40, Moritz Neeb <lists@moritzneeb.de> wrote:
> > I suppose just fixing/revising this would be kind
> > of a too low hanging fruit?
> 
> I am in no way qualified to speak to the majority of your post, but I
> can't imagine anyone refusing your work because it was 'too low
> hanging fruit'.

I would agree that it is *not* a "too low hanging fruit".

The thing is, it would be a really easy way to get into the groove, to
understand how changes are expected to be contributed, what the process of
iterating the patches/patch series is, and in what form the patches are
preferred.

Moritz, if you worry about this lil' project to be too little, why don't
you just start with it and then tackle another one? That way, you will be
already very familiar with the Git project (and the regulars will be
familiar with you) when GSoC comes around.

Ciao,
Johannes
