From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] Purest update to bash completions to prevent
	unbounded variable errors.
Date: Tue, 13 Jan 2009 08:46:24 -0800
Message-ID: <20090113164624.GT10179@spearce.org>
References: <496CBC98.7090101@tedpavlic.com> <20090113163421.GQ10179@spearce.org> <496CC3E7.8060805@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 17:48:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMmQv-000577-4W
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 17:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757960AbZAMQq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 11:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755492AbZAMQq0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 11:46:26 -0500
Received: from george.spearce.org ([209.20.77.23]:45894 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755815AbZAMQqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 11:46:25 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7352038210; Tue, 13 Jan 2009 16:46:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <496CC3E7.8060805@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105512>

Ted Pavlic <ted@tedpavlic.com> wrote:
>> Your commit message leaves a lot to be desired.  I would instead
>> have written something like this:
>
> I agree completely. Sorry about that. stg fired off vim to edit the  
> commit message, and I just wasn't thinking.
>
> Would you like me to modify the commit message and resubmit?

You probably should, to be nice to Junio.  Its far easier for the
maintainer to save off well formatted messages to an mbox and run
"git am" than it is to stitch it together from different emails
and/or hand edit messages to make them work.

-- 
Shawn.
