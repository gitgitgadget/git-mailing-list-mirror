From: "Chris Hoffman" <chris.c.hoffman@gmail.com>
Subject: Visual SourceSafe -> Git?
Date: Tue, 27 May 2008 09:20:07 -0400
Message-ID: <63c5d3820805270620t1fefdf95q6407bd053a2daa88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 15:22:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0z6r-0003Sf-Hn
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 15:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757353AbYE0NUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 09:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757306AbYE0NUJ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 09:20:09 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:48475 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757092AbYE0NUI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 09:20:08 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2938279rvb.1
        for <git@vger.kernel.org>; Tue, 27 May 2008 06:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=4TKFm+oyR7a9bww6jv5YoGXOobM2LDAa5Cmjz7C+nbs=;
        b=DQZwKD32ai6ND0BmBn7CO5/As9gXZ3X+4lwQM2VhE6j4Kwoze6SZ21btJ+vjLiLBl/9xyN8ZrHc0HXR19plVrYTse5GWk8rmMPniXQAMpRL0q1FOEWrEykr/OwW8LGSPRYXIBxWrzN9Y1t4MExHXgnyKlJb3PISxpqdYKNbADy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WehVHWxWU18rVycZF7LdSsyjirfN6lX1eMdeuIfkGjcgGReDr20tQOvtnTTByPeTOwuAqhdV5nASCKRpif8aUg4J6tZHFySL955TVG8FPkAt/bsEHD7PygQAVdJU3Gyw2vJnH3UYcdB1yjPhhXwD3XeHPGU6jFKJUTzETB2gwu0=
Received: by 10.141.202.12 with SMTP id e12mr531936rvq.273.1211894407375;
        Tue, 27 May 2008 06:20:07 -0700 (PDT)
Received: by 10.141.87.15 with HTTP; Tue, 27 May 2008 06:20:07 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83011>

Hello,

Is there a tutorial/script out there that would allow one to convert
an old-and-busted VSS repo to Git?  I was thinking about going the
subversion route, but I still have nightmares of the days when I was
having to do complex merges.

Thanks!

-Chris
