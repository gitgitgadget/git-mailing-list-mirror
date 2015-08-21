From: Guido Vranken <guidovranken@gmail.com>
Subject: Where to report security vulnerabilities in git?
Date: Sat, 22 Aug 2015 00:55:19 +0200
Message-ID: <CAO5O-EKaarYDBd-cpVvKVXTWfKm10ttqd3A6wNe2cXGriGux1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 00:55:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSvDZ-0002wz-9P
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 00:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbbHUWzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 18:55:21 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:35373 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbbHUWzU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 18:55:20 -0400
Received: by iodt126 with SMTP id t126so97547594iod.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 15:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=vwBTi5BuV6hpbhbOWIg3MdxSWQ6fCQ/b1uE5KaySZJk=;
        b=I5OtUYoFsKoubmU8hSwPw+LJpxwtfpw1yZjBufJiFFKiqJS8YTO84GTx65s8PYHP9m
         Rwiv3oJBT2mPGZoLbcTFPmfUHviiQ3J9glQgVeZbVEsk+9/8KiZVxzohB/vfabJyoNZd
         CYD593idWLg0MMri5ZnUb2kGdnJ1VtmV9AJzT7qhl4ISiQ4d9rBtL2AbBHKmYbSnWxBH
         +tDBs9UtzmxdDKGprV7J+UZ9MWmwM1GuDIZHxZlpzx4l13bKQjbZeDkNkVOToZRh6bCi
         qy4045iNTJ9Hz7b55gV7ZzcInpZGVv8lAdt9qhaMJYNft6/IQiv6icZvjHPs5+ttGWqQ
         GHlA==
X-Received: by 10.107.136.99 with SMTP id k96mr10769678iod.67.1440197719490;
 Fri, 21 Aug 2015 15:55:19 -0700 (PDT)
Received: by 10.36.72.141 with HTTP; Fri, 21 Aug 2015 15:55:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276341>

List,

I would like to report security vulnerabilities in git. Due to the
sensitive nature of security-impacting bugs I would like to know if
there's a dedicated e-mail address for this, so that the issues at
play can be patched prior to a coordinated public disclosure of the
germane exploitation details. I did find an older thread in the
archive addressing this question (
http://thread.gmane.org/gmane.comp.version-control.git/260328/ ), but
because I'm unsure if those e-mail addresses are still relevant, I'm
asking again.

Thanks.

Guido
