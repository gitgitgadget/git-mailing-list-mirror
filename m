From: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
Subject: Import existing (old) topic branches in topgit
Date: Tue, 14 Sep 2010 22:44:22 +0200
Message-ID: <AANLkTima2NsEWuT85oFZGpfCQrsrqy5KsQSOez3B9i-7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 14 22:44:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvcMg-0000uH-0K
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 22:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204Ab0INUoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 16:44:25 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51922 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab0INUoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 16:44:25 -0400
Received: by wwd20 with SMTP id 20so209098wwd.1
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 13:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=a9pjocyUgKd/G1DMeBVoIx5L/mdQOya3ZrVUb1uyrcg=;
        b=drB1d0m731PH7CCb8VovVe2mw6KtGAUScGknpFqglSFze2xn1TZj3nqWcMAdr3Sabq
         jkIGU3Li+WRqtdusFDRYlaP/6cBuIzYgJZokbFJkcYqmkU0y/loWO4rVlUu3A3M/i6gz
         KXnaQ9hWhWnnjtA7AiUjcdYh0d9Yaxqn99kM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=pIS77YahQLrg9ny5TFexYmOeabh4f+OpouXFuppqfQLVdOJBWK4Ev30bsGFDTbpXFR
         cpG/RuuXY0hJqXQ+RtgFseuo+y8lVXtKm3IJtA/Cdsn7dEWDZ2yoqrgNqfL/gW8wduYS
         pg8FipIsHSzz6e2EvucCVonRUl7XhQky6kIqU=
Received: by 10.216.38.20 with SMTP id z20mr346173wea.108.1284497063020; Tue,
 14 Sep 2010 13:44:23 -0700 (PDT)
Received: by 10.216.153.193 with HTTP; Tue, 14 Sep 2010 13:44:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156212>

Hi all,

After trying to manually maintain many topic branches before sending
them upstream, I recently discovered that topgit seems to become my
best friend.

But as I'm new to this tool, I don't know what's the best way to
import existing branches in topgit.

What I mean is:
* I already have topic branches, with long history and regular merges
with upstream.
* I want to manage the related topic via topgit
* I whish to keep my own history (if possible)


Can experimented users give me some tips on how to do this?

Thanks in advance.
-- 
Guilhem BONNEFILLE
-=- JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
