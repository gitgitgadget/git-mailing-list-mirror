From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: GIT get corrupted on lustre
Date: Thu, 17 Jan 2013 15:23:29 +0100
Message-ID: <CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca>
 <50EC453A.2060306@giref.ulaval.ca> <50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Maxime Boissonneault <maxime.boissonneault@clumeq.ca>,
	=?ISO-8859-1?Q?S=E9bastien_Boisvert?= 
	<sebastien.boisvert@calculquebec.ca>
To: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
X-From: git-owner@vger.kernel.org Thu Jan 17 15:24:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvqOI-0002vZ-Ut
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 15:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584Ab3AQOYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 09:24:03 -0500
Received: from mail-oa0-f42.google.com ([209.85.219.42]:61315 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab3AQOYC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 09:24:02 -0500
Received: by mail-oa0-f42.google.com with SMTP id j1so2684453oag.15
        for <git@vger.kernel.org>; Thu, 17 Jan 2013 06:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=R451NVs1jb30oCgdmJtkIvroRpbfesbiNWqSCFI2BmE=;
        b=a4s1GtdFpLB4EPh1I0oCPHHRHHDRd9G9A/z8vSmRwiyELmz6/dozr3XSvhsSHKu9sX
         +zGHbkGnhNxlyuzUw+EKbgmGS4E8Cq5H+hFEGvl4yp0DGGTbUZjTIA7znfEQscokTIS3
         DD8oUHo/CFeT26Es/qSal2aBaweX4zb4SE1Ehed0wNiGmInd2GH9SQdgeoxUKNUrvfLh
         x/EgoW5Sz57tvRRS60ZtD31fyjqRdfDu/tLYE5FhEDc5q5UeVkWenJPONnKDxtukjOf0
         4GAVKrmbpenO7VefD/4lAMsoTn/jbzSPp45pKbHQgpw9YHVOhuoPHPHh08rJqVefzVtE
         cjiA==
X-Received: by 10.60.13.73 with SMTP id f9mr3881162oec.131.1358432639379; Thu,
 17 Jan 2013 06:23:59 -0800 (PST)
Received: by 10.76.82.200 with HTTP; Thu, 17 Jan 2013 06:23:29 -0800 (PST)
In-Reply-To: <50F7F793.80507@giref.ulaval.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213853>

> Anyone has a new idea?

Did you try Jeff King's code to confirm his idea?

Philippe
