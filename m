From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git for Windows 1.6.3.2
Date: Mon, 8 Jun 2009 12:51:50 +0200
Message-ID: <fabb9a1e0906080351hbfe7ab7w2016a030ef1bde7@mail.gmail.com>
References: <alpine.DEB.1.00.0906071629460.26154@pacific.mpi-cbg.de> 
	<26984.77.61.241.211.1244457815.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Mon Jun 08 12:52:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDcSk-0001lL-9T
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 12:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284AbZFHKwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 06:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbZFHKwM
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 06:52:12 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:58791 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217AbZFHKwK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 06:52:10 -0400
Received: by ewy6 with SMTP id 6so4036120ewy.37
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 03:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=cvixq+NDiuFXsNP9k7wXioABQ0LuVq+p51D0ydDVM+k=;
        b=eZ7CNVoupPYvgWgK5Q/BiaE0GksHeStVpABIa3xuGz3svg0pxEodHnNG4xtTm52UGi
         NJ03YXFocWsQwNKRyeuxPr+V1P9mGEHmq1L7qLGsXUX+UGyw8C3sVeqMsLf4kO8jqjlK
         S6/Msko1WAuK8RUBRiZyXTD4+NzlprCXX97ug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=h9Jj4sGbJDyIAnhJkkPICW5Ll4/PLMp1dg6kq+H9SzDmILQF67n/FSRYENu8O7PZYa
         fmH7bENIV6vanaFyNctvUe9lPUmJRwKnA/j9TeU55rxTOTlAmJbKlWpbhdNsr3hMg2fz
         L88H4eJynMyve61U2AfsxGMzD4hxz+/brx5FU=
Received: by 10.216.73.85 with SMTP id u63mr2254568wed.37.1244458331105; Mon, 
	08 Jun 2009 03:52:11 -0700 (PDT)
In-Reply-To: <26984.77.61.241.211.1244457815.squirrel@hupie.xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121059>

Heya,

On Mon, Jun 8, 2009 at 12:43, Ferry Huberts<ferry.huberts@pelagic.nl> wrote:
> this does not work for me.

Perhaps you want to define 'does not work'

> with this patch it is fixed/reverted:

I doubt simply reverting the 'fix' is going to be a good idea,
methinks the original fix was done for a reason, no?

-- 
Cheers,

Sverre Rabbelier
