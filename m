From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [WARNING] Proposed future changes that are backward incompatible
Date: Fri, 27 Feb 2009 20:51:22 +0100
Message-ID: <fabb9a1e0902271151qa649d2en6b49e8794f93b889@mail.gmail.com>
References: <20090227192708.6266.qmail@science.horizon.com>
	 <alpine.LFD.2.00.0902271439310.5511@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: George Spelvin <linux@horizon.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Feb 27 20:53:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld8lS-0008SV-Qm
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 20:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243AbZB0Tv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 14:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755843AbZB0Tv1
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 14:51:27 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:54979 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666AbZB0Tv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 14:51:26 -0500
Received: by fxm24 with SMTP id 24so1205648fxm.37
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 11:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sqM6MFaSoLtYp33qMOmHcRE5D4gibbRL68QfU8bvcrw=;
        b=TP6h38jNupGTnhYrVpX5J9mxdOxWn/WIx1AKTdVd0GoHO0EfbBWPQbv1F70upoJTOj
         +6JziJAWPZUa3iPpQ5aGcTGRgK/Hf20zYfRmPl+dbVByuWx0xuzV9sGN1OwQugEeYm9K
         nKpmICs1lq4A/asen6UH+TTDgnhDa3dVSHXow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OnCkga/tMfgaG/0q2U6yP/xQaeLaJ26X/nK0ta8GNKW6IwOJCjWiqo6PCa/os3gfxe
         vGz2VY0fO9nJfV4+Nh/+URKfWETqRoq6KQjSGfghYgxgavSVWgHBrWsvuIs81hAnxvLi
         ZRvXagQ7kGFiJYoLgrk/JtiTCZoG8hsbquP3U=
Received: by 10.103.182.3 with SMTP id j3mr1465040mup.113.1235764282947; Fri, 
	27 Feb 2009 11:51:22 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0902271439310.5511@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111705>

On Fri, Feb 27, 2009 at 20:42, Nicolas Pitre <nico@cam.org> wrote:
> [nico@xanadu git]$ git grep Alice

Now try again from within a subdir ;).

I actually prefer the current behavior, and am a very extensive user
of it. Config option? ;)

-- 
Cheers,

Sverre Rabbelier
