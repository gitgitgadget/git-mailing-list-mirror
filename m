From: Kevin Ballard <kevin@sb.org>
Subject: Re: To page or not to page
Date: Fri, 2 May 2008 12:56:46 -0400
Message-ID: <247FB870-E42E-4FFA-B230-8A377748C731@sb.org>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <7vlk2txn8n.fsf@gitster.siamese.dyndns.org> <8C3474E2-3A4F-44E8-B301-C36939C7BA11@sb.org> <807E185B-BEE5-4AAF-8DF4-EE597681D61C@wincent.com> <20080502123656.GA2680@sigill.intra.peff.net> <7D1C3FC4-9FC0-49E5-929C-CDEF5FAD3D02@wincent.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri May 02 18:58:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JryZn-0001l5-Cf
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 18:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642AbYEBQ4t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2008 12:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbYEBQ4t
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 12:56:49 -0400
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:37962 "EHLO
	randymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757184AbYEBQ4t convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 May 2008 12:56:49 -0400
Received: from [192.168.0.215] (c-24-91-11-245.hsd1.ma.comcast.net [24.91.11.245])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a5.g.dreamhost.com (Postfix) with ESMTP id B85188FB82;
	Fri,  2 May 2008 09:56:47 -0700 (PDT)
In-Reply-To: <7D1C3FC4-9FC0-49E5-929C-CDEF5FAD3D02@wincent.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81010>

On May 2, 2008, at 12:13 PM, Wincent Colaiuta wrote:

> El 2/5/2008, a las 14:36, Jeff King escribi=F3:
>> On Fri, May 02, 2008 at 12:34:10PM +0200, Wincent Colaiuta wrote:
>>
>>> But evidently given that there has been so much backlash against th=
e
>>> patch the only way to keep everyone happy will be to make this
>>> configurable.
>>
>> Agreed.
>>
>> But I wonder why there seems to be such a split between people who
>> clearly have short git-status output, and those who have long git-=20
>> status
>> output.
>
> I generally try to work on one thing at a time and keep the status =20
> output short -- and I imagine that that's the way most people work =20
> -- but there are certain things where long output is going to be =20
> unavoidable, like renaming a directory with lots of files in it. And =
=20
> when that happens, seeing only the bottom of the "git status" output =
=20
> and not the top is not what I want 100% of the time.

Doesn't your terminal have the ability to scroll? If my git-status =20
output is longer than my terminal's height, I just hit Page Up to see =20
the top.

-Kevin

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
