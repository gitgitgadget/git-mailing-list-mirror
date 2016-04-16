From: bin wu <idevcod@gmail.com>
Subject: Where can I find the MD5 or SHA1 of git preview client.
Date: Sat, 16 Apr 2016 21:44:01 +0800
Message-ID: <CAM8n_hso=ZGa9Mwz4fYuqFz7bGN2gAtCx2CLxVv+onC9ozRTaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 15:44:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arQWE-0007UE-Sz
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 15:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbcDPNoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 09:44:04 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35834 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbcDPNoD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 09:44:03 -0400
Received: by mail-yw0-f193.google.com with SMTP id k197so18178565ywe.2
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 06:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=wNs4nx18zJV3jvS0pgYcLV4YVMMyb99SOgUytZeCGoY=;
        b=L20DYyzCqqN7slSAk3cQbD+ydphcds6JvJ4J08+4FZbcYVpWTCKAEaq5h/RbBnu/jj
         ad5QfitzzbIH3uOIKKeauw9+GDIn9dz0SBkPYidEijBChifTFLH72lR6NP5wLfRcZ6R3
         l5UBaaSCe0wLHU8XFiM30ecbktPh9mUbkcRZz7+b3EzvUPae2xQSXNjuA8DTTQ+73Cl5
         srf1YtTZbnCu8tLwo9OBfaiJCv9+WmMx2Q+/jRoENeWjOyDiJvXl+ThCCF1QEPoK3vAb
         yPVJ+I5XN0sHxqyjBH4ORdhpAs7FF+QA7E/4LzPA4uOKbO1ymUSUQ179D7m4XTNveX/0
         kjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wNs4nx18zJV3jvS0pgYcLV4YVMMyb99SOgUytZeCGoY=;
        b=XS+s3/22p2TOOi0ykF0NwPSjQkPACN+sF+5++6SVWhf/MFrTlINSR3aKZtNgg4qdQz
         AOT/A6u9Txz48GbXVd+LW2/FVQ21KXX/KOMjMgIBL/wSZ65JDOqrsGSiKC3uOG7u5y+m
         f+zdWVYbmve0FUDAbi+Pn7cdieOFeiAcFVgOyWuB2z9ZpVVMV2RubZm4MF9VDEIwxsCG
         M4wnIJ3HQ9/BZGmVX2iNpTNPzTF+YKN5jyqZuJ1mEvgj0D8XWe/ah0Ua8NnZ8D6ZZ3t6
         CywKmcz5gjggrcUjN+y7lPBFq5WQKgJlXBSaNKFxYCRpbsEa/dD+OCzQWzZ3FEL6sYnB
         612g==
X-Gm-Message-State: AOPr4FWoway3anUC2kBPgVUFrfM7F4rJWpSS5kBOkDgDw7432G65hDPll4KqAKQsAzBHn0fnN6441ZmZ7JYQnw==
X-Received: by 10.129.87.203 with SMTP id l194mr1848900ywb.228.1460814241644;
 Sat, 16 Apr 2016 06:44:01 -0700 (PDT)
Received: by 10.37.77.67 with HTTP; Sat, 16 Apr 2016 06:44:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291722>

Hi,
   When I download git client from https://git-scm.com/download/win ,
I want to check the MD5 and SHA1 after finished downloading. But I can
not find them. Where can I find them?

BR.
