From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Plans for 2.7.1?
Date: Tue, 2 Feb 2016 08:56:59 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602020845300.2964@virtualbox>
References: <alpine.DEB.2.20.1602011740540.2964@virtualbox> <xmqqvb68utby.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 08:57:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQVpt-0005Uv-Uh
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 08:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515AbcBBH5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 02:57:14 -0500
Received: from mout.gmx.net ([212.227.17.21]:55613 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752874AbcBBH5N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 02:57:13 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MQdAP-1acnMP44hJ-00U6hq; Tue, 02 Feb 2016 08:57:01
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqvb68utby.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
Content-ID: <alpine.DEB.2.20.1602020852371.2964@virtualbox>
X-Provags-ID: V03:K0:kKJ/GnCp5SAAXJ5Vs0STVdFzIsFbgEpAahnvkU4+kn51Ag4oxfq
 3MzdaZhp0wmySRxbpsqud/LFc0UjnJyZ033JG2qXm/hGmgqG0MOmDA4NTxY2kqRpW+VtG5g
 1k19w1W3X3hVN5rY4YcIazpItLuJ92fVY6HYXjxcl6fqcvTSOhRJTtudZG8pUKmu3lLBc9g
 gtmFgMRRxmojssTY4Dv0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BQBOugC3xQA=:+BxgVrbjnnUvb+NgpnfDIj
 sYFJGO7pTm/zdF3wwzllOEVE19l+gleBI3/L5yC4/E0qj9ttrs5MZf8qsaFI/Eev4OMPYTxoB
 G/abDDnrAreafzz3b831LfvCQzExYoP7WpkwXJ9Gsdeje87VfMjCvP/H3dEjapWzO9nelCO+z
 V3MZtb0Tj74tt4ai1L5TfylJQs/4qIJGmb6M0H/nROWRnJlDBXsJh/KE7zcXpZPuYA7jpF3JG
 z8+1dDZ2ytTpRvK5mk2SAJ1TRX579JImOG2XT1Nf+4Ndnq6U5q/tulD18GEw26Jg+aYWb7mnO
 ZWj7R80tbdZ4C4H3BZrPEPexmf7hsKsOs7hbL4ju950PvvVzHug05aVczuTo9Xjen5ACc7MqJ
 uUIaNz67Caa01s9gf0a7TMrZjechbJMAV3Rvb1m1ZG6oX+eLcF8FDkH6DggfY+4GDvv8+gC4i
 EYxtGujcR0dZLRY2UqBE2V32NX5kljTXUW8XJ+iQeD/3Z4sqv6G4+SRVMscRKlq3Mw48pXI6G
 49ocdNqKxrK7A5ta2DLkdQRYLB7iTfj+V5H+sdoxWC4/bD/TQVA034S7B4MRaNStLE5B5HNUY
 jKTL4bhtSjx6mCAedCS5u4+ibijpbbRJpm/UsmiZw8JqEKO+vfHiNU5UsKNcROfXTKjkk6wbM
 YFQpWomSEnZTT/qQcAIEbI7v6rJZ+S9hyJTwq08Z5lDpMFUw8PhYFbux10hiZeuZVj+vBGGLh
 4MHSRKmWem4WFDQcGUaNh0NUx3p2vUBIY/82nMjVWdwffVGi71r2CGnj0gsCqF8tFYc8SrDD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285242>

Hi Junio,

On Mon, 1 Feb 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > at tinyurl.com/gitCal I see a pretty timeline regarding 2.8.0, but I
> > do not see 2.7.1 planned anywhere.
> 
> Yup, because maintenance releases are inherently "not planned" ;-)

Of course, I know. Though as you dropped a hint that it might be imminent
in http://article.gmane.org/gmane.comp.version-control.git/283579 I
thought it might be in that calendar somewhere.

> Let me see what are slated for 'maint' in the current draft release
> notes.
>
> [...]
> 
> I would want to see jk/list-tag-2.7-regression and ew/
> svn-1.9.0-auth topics also in 2.7.x track soonish, but they
> currently are still in 'next', so perhaps late this week or early
> next week?

No rush. I'll just do a 2.7.0(2) today.

Thanks for the detailed information!
Dscho
