From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: Where should git-prompt.sh be installed?
Date: Thu, 25 Oct 2012 04:10:42 -0400
Message-ID: <5088F402.8090006@mit.edu>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com> <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com> <20121025005106.GA9112@elie.Belkin> <3B606942-D194-4148-AF6E-1F3283C983ED@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ted Pavlic <ted@tedpavlic.com>,
	=?windows-1252?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Dan McGee <dan@archlinux.org>
To: Danny Yates <mail4danny@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 10:16:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRIbp-00011U-QH
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 10:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759257Ab2JYIPx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Oct 2012 04:15:53 -0400
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:43416 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759230Ab2JYIPv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2012 04:15:51 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Oct 2012 04:15:51 EDT
X-AuditID: 1209190c-b7f286d000000ee3-f3-5088f409475a
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 9E.0D.03811.904F8805; Thu, 25 Oct 2012 04:10:49 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id q9P8AlYN032742;
	Thu, 25 Oct 2012 04:10:47 -0400
Received: from [192.168.9.38] (c-66-30-114-241.hsd1.ma.comcast.net [66.30.114.241])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id q9P8AgTc018601
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 25 Oct 2012 04:10:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <3B606942-D194-4148-AF6E-1F3283C983ED@googlemail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixCmqrcv5pSPAYOsTNost+8+wWxx8nGfR
	daWbyeLtzSWMFnd/z2Gx2N2aZdGxvpfRgd2j8cg9Ro+ds+6ye7w71cDqcXHnZyaPz5vkAlij
	uGxSUnMyy1KL9O0SuDImvm1mLzjEWrFw7gn2BsatLF2MnBwSAiYSv95Ph7LFJC7cW8/WxcjF
	ISSwj1Hi4swjTBDOBkaJO+c+sEA415gkfr7rYgNp4RVQk/ixeA5YO4uAqsTn92/AbDag+NwN
	k9lBbFGBMImPMzYyQdQLSpyc+QSsRgSo5ueLw2DrmAWWM0m0n1gI1iAsYCrx4MkZqG0PGSUa
	175hBklwCjhJ/DryiBHEZhawlbgzdzczhC0v0bx1NvMERsFZSJbMQlI2C0nZAkbmVYyyKblV
	urmJmTnFqcm6xcmJeXmpRbqGermZJXqpKaWbGMERIcmzg/HNQaVDjAIcjEo8vAc8OgKEWBPL
	iitzDzFKcjApifIGfAAK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuHd/h4ox5uSWFmVWpQPk5Lm
	YFES572cctNfSCA9sSQ1OzW1ILUIJivDwaEkwWv0GahRsCg1PbUiLTOnBCHNxMEJMpwHaHgA
	SA1vcUFibnFmOkT+FKMux4al8x4yCrHk5eelSonzSoAUCYAUZZTmwc2BJbJXjOJAbwnzKoJU
	8QCTINykV0BLmICWmPO0giwpSURISTUwro81XmTw7eHfIz8slhz7L6G5+v0VnqsPmhMvVmfq
	s7c8ttfZt++J3DFFKRvjwszcI8X31oeUSfF3fJ20pVEuX7rtxA3d8mh2/v/3+yLq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208363>

On 10/25/2012 02:02 AM, Danny Yates wrote:
> Would that not give the impression of "git sh-prompt" being a core
> command?

No more than git-sh-setup, which already works like that.  Unless=20
perhaps by =93core=94 you mean =93not contrib=94.

(Now that I think of it, I saw a request from an Ubuntu PPA user last=20
week to install git-subtree in a more accessible location, and there=92=
s a=20
similar request about gitview at https://bugs.launchpad.net/bugs/152212=
=20
=2E  These are less critical since the Debian package puts them in=20
/usr/share/doc/git/contrib.  Is it a good idea to package those=20
somewhere like /usr/lib/git-core or /usr/bin, or is that a dangerous=20
slippery slope?  I dunno.)

Anders
