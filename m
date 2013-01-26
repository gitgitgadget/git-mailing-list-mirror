From: Craig Christensen <cwcraigo@gmail.com>
Subject: Port 22
Date: Sat, 26 Jan 2013 11:56:48 -0700
Message-ID: <55B0A474-AD5B-44B5-91E7-FA5253FA5682@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 26 19:57:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzAwA-0000Qg-AA
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 19:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab3AZS4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 13:56:49 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:65036 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab3AZS4s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Jan 2013 13:56:48 -0500
Received: by mail-pb0-f43.google.com with SMTP id jt11so766445pbb.2
        for <git@vger.kernel.org>; Sat, 26 Jan 2013 10:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:content-type:content-transfer-encoding:subject:date
         :message-id:to:mime-version:x-mailer;
        bh=A/UtfmaR6AcUX3CxGGgEU2iYGGPARebrNFyAFYtNcyQ=;
        b=FbdUrLL8zxHpKPpP0P5nG178jjHB7vjA6RPoy97mGZ9pQOEdGOkfb1l1wDRAyovb6n
         lOROD62Yt9mjf/QP9dTylGIZBz0E4SQS0QnhfqH6lxtIwhl7HZUFrJJYeL+mEuhBAQet
         tl9yvDtoSFiKy25g9pVnCxh5GXyEqmYJELRF1jnv5O2OXNDhtT/zeziS7cNzI+62yIyB
         LFyekrMRBoeuVUGuwEip0Kp45CLN4kbW7eRGBIZ+X4vdaIByMVhhDDvl2/fctfZvf9iv
         a9x7tH2/7BWJqqmFUKTTDd+WPDBzYAobI1Lkt4uOohSjwNYujUXwWLEMZbOoodC1nD0b
         ws4w==
X-Received: by 10.66.78.168 with SMTP id c8mr23527371pax.16.1359226607956;
        Sat, 26 Jan 2013 10:56:47 -0800 (PST)
Received: from [10.18.149.57] ([157.201.118.66])
        by mx.google.com with ESMTPS id a4sm3282944paw.21.2013.01.26.10.56.46
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 26 Jan 2013 10:56:47 -0800 (PST)
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214631>

I am currently a student at Brigham Young University - Idaho and we are use Pagoda Box and Git for our Mobile Apps class.  However, the school's network has blocked incoming trafic on port 22.  I have been searching through all the tutorials and documents provided by Pagoda Box and Git but have not been able to find a solution to solve this problem.  We can use sftp but we then have to manually deploy the latest using the admin panel.  Can you help provide a simple solution?

Thanks,

Craig W Christensen
cwcraigo@gmail.com
chr07035@byui.edu