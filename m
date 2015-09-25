From: Valentin VALCIU <axiac.ro@gmail.com>
Subject: Formatting error in page http://git-scm.com/docs/user-manual
Date: Fri, 25 Sep 2015 15:38:02 +0300
Message-ID: <CAOq7JjbYP=fGB0aqbrMz_ibfWHor-v-Y-BsO316H4dHpfSYS-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 25 14:38:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfSGS-0004ZZ-1i
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 14:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983AbbIYMiG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Sep 2015 08:38:06 -0400
Received: from mail-la0-f68.google.com ([209.85.215.68]:36375 "EHLO
	mail-la0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412AbbIYMiF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Sep 2015 08:38:05 -0400
Received: by laka1 with SMTP id a1so356576lak.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 05:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=uh8mJEhttc4QTgagxu4O89F8/wHcfYYGVCNnYpbzdKU=;
        b=tPDclfQJFLwKa5jF1DTf9uwUOWsi3BI9xvPGLA1GkfGa8FYr5NI3YNT46hp7XfOFew
         hO7ZFq2DypHiuXXb05mcPx51BIBTKkMO6alpPn/c1JmHNEGtcklZk6yir+BQM60jBu5i
         bLD2cij/9ulpCF+teX63dp5aPU6ZDyw3vivFQfsrQme5z8aIR4KnETqHw4pjrwZoVdKY
         FbGtPdrxZEJQONwxEXCyNxVY35D9esOzUPXj5ENrk/rViZrwytGWLkdSo+cW3np9z+JM
         fo0X0PzOdVbvfkdvIm7dlxuIjmUmCV9SC3bHOotUXWaASAtNCc75GFRV7jdlP9PDotL7
         mglg==
X-Received: by 10.25.82.79 with SMTP id g76mr1047708lfb.110.1443184682918;
 Fri, 25 Sep 2015 05:38:02 -0700 (PDT)
Received: by 10.25.16.148 with HTTP; Fri, 25 Sep 2015 05:38:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278658>

Hello!

There is a formatting error in the source code of page
http://git-scm.com/docs/user-manual that makes almost half of it be
rendered in a <pre> element displaying the page source in the original
markup language instead of being converted to HTML.

The issue is in the paragraph that stars with "The index is a binary
file (generally kept in `.git/index`)..."


Regards,
--
Valentin V=C4=82LCIU,
Bucharest, Romania
