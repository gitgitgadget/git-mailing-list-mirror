From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2] Add push --set-upstream
Date: Sat, 16 Jan 2010 01:55:07 +0100
Message-ID: <fabb9a1e1001151655r515374f3ybe2a7d4fb20ea532@mail.gmail.com>
References: <1263595630-18962-1-git-send-email-ilari.liusvaara@elisanet.fi> 
	<7vzl4frl7i.fsf@alter.siamese.dyndns.org> <7vfx66sz5p.fsf@alter.siamese.dyndns.org> 
	<20100116090321.6117@nanako3.lavabit.com> <7vk4virjzh.fsf@alter.siamese.dyndns.org> 
	<be6fef0d1001151653o7ba2cf7et8875eaf4333fc15a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 01:55:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVwwt-0003l1-JC
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 01:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758381Ab0APAz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 19:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758377Ab0APAz2
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 19:55:28 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:51156 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758372Ab0APAz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 19:55:27 -0500
Received: by pxi12 with SMTP id 12so1299949pxi.33
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 16:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=/O/mxzm/mpyyPSJRr36buCQtu8WHGoWqQpCpz2pw8bw=;
        b=mVAu1qduivHOWNCC4+F1POXEjCydu11J5povZ4MJU/MJmZwdMeeBsYUoL7rAf5IKjq
         6qzaRN0D0UPugscQ9x7R4gAXdVPS+wZUmCL4DesEDh49vzqd/+sNim9ZdO8nTgCWHIE2
         32jqr/pvOz1AI0W46hl6z+1xXyoFpHcZz5bVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ttf5+bjDKb56tF/kYL9rP09j9n5xtRPzR6DSdBqmQuXDaTLHtzOemkjjfRMeDsOy19
         1Tu4xlwIEByR9P8ZF9RSs8Yx5zYQ2Z76HUkQu0xavbSIXrjJUJnQhmqcNLjEKmlW5YO5
         +dSW+vlmVOv21wX5NldWa3OEf5Ft2VkoN92kI=
Received: by 10.142.55.3 with SMTP id d3mr2131179wfa.259.1263603327084; Fri, 
	15 Jan 2010 16:55:27 -0800 (PST)
In-Reply-To: <be6fef0d1001151653o7ba2cf7et8875eaf4333fc15a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137177>

Heya,

On Sat, Jan 16, 2010 at 01:53, Tay Ray Chuan <rctay89@gmail.com> wrote:
> how about --setup-merge and --setup-rebase?

I like it, it also suggests this should be called '--setup-upstream', no?

-- 
Cheers,

Sverre Rabbelier
