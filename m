From: Dinesh Subramani <dinesh.subramani@gmail.com>
Subject: Git Log and History Simplification
Date: Mon, 17 Dec 2012 17:03:09 +0530
Message-ID: <CAE116wxTY0sFh5nZwGEYRz=gJwXgFEj8Nvwh41RCYH4vgYCqSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 12:33:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkYwq-0006L2-Fc
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 12:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255Ab2LQLdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 06:33:11 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:35359 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab2LQLdK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 06:33:10 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so5365746iay.19
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 03:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=HHsWEj2H5jxdL8gql5TGqSXK/rsJ1IhPXGdEztG/EM4=;
        b=UO09WFrlY7aASy2qPdbLWY7JX6Qhj0qdJFDpe54EWvgA8pKBEv5Q8C5+qXHTZ+NIst
         1xE2756R05Fb4SoLxLln6nuvPcbC3h1aXv7/iU1t+FBWEcU0SviXw895BLWR6syVv/1x
         yKqKqHbDKenvFfTproVRr3Q7xr/M/q8yRQwdt7o7ERC0hCOGLdbLJk5w8g4Jmm0ThGYE
         lcBtFjG5nUHKZj34dj2e/R3xlRS9jorqbEz1nq43MYq+0CFqKjGGrwNFyFWzrOcNjt0B
         T03YKMMHgI0VydI7V/8AB+wEpqXZfwCzKeoOKjaPDHxYax5EnGeMf58Hdle9WNHmJdkK
         Qnhw==
Received: by 10.50.57.200 with SMTP id k8mr8777685igq.29.1355743989762; Mon,
 17 Dec 2012 03:33:09 -0800 (PST)
Received: by 10.64.53.169 with HTTP; Mon, 17 Dec 2012 03:33:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211675>

I am using the below command :

git log --stat --decorate=full --since=<date>

Can you please let me know if the above command will list all the
commits and would not skip any of the commits due to History
Simplification. Any help would be very useful.

Regards,
Dinesh
