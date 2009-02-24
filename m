From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [EGIT] [PATCH v1 1/1] Add an ignored icon
Date: Tue, 24 Feb 2009 07:11:00 +0100 (CET)
Message-ID: <42268.77.61.241.211.1235455860.squirrel@hupie.xs4all.nl>
References: <cover.1235415747.git.ferry.huberts@pelagic.nl>
    <ec97c536d418f465befba2a7f30f82f0d75004f8.1235415747.git.ferry.huberts@pelagic.nl>
    <49A33862.90507@gmail.com> <49A38282.8020308@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tor Arne =?iso-8859-1?Q?Vestb=F8?= <torarnv@gmail.com>,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 07:12:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbqWv-0000bS-BK
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 07:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbZBXGLH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 01:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbZBXGLG
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 01:11:06 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:48694 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751339AbZBXGLF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 01:11:05 -0500
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id E3FD058BDBB; Tue, 24 Feb 2009 07:11:00 +0100 (CET)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Tue, 24 Feb 2009 07:11:00 +0100 (CET)
In-Reply-To: <49A38282.8020308@pelagic.nl>
User-Agent: SquirrelMail/1.4.8-5.el5.centos.3
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111217>

On Tue, February 24, 2009 06:15, Ferry Huberts (Pelagic) wrote:
> Tor Arne Vestb=F8 wrote:
>> Ferry Huberts wrote:
>>> Add an ignored icon to the label decorations page and make
>>> sure that it is actually decorated: from now on do not ignore
>>> ignored resources during decoration.
>>
>> The reason this was not added in the original series was because tha=
t's
>> kind of the point of ignoring a resource -- you don't want any
>> information about it. Also, none of the other team plugins provide
>> decorations for ignored resources-
>>
>
> I could also argue that I want everything to be explicit, even the
> status of ignored files :-)
>
> If you look at (for example) TortoiseSVN then you'll see that it does
> provide an ignore icon. My icon was sort of 'inspired' by that one.
> Don't know if it's on by default though, will have to check that.

I just checked, TortoiseSVN has the overlay for ignored items on by def=
ault
