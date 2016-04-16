From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: Git mascot
Date: Sat, 16 Apr 2016 13:17:01 +0530
Message-ID: <5711EDF5.6090502@gmail.com>
References: <CAEC5eqHEVr=k+UP8vG20L8Si-phYwZ5TLFr_dch=9_vM-99gYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: rsbecker@nexbridge.com
To: Christian Howe <cjhowe7@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 09:47:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arKwl-00024w-PP
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 09:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbcDPHrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 03:47:08 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36706 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbcDPHrH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 03:47:07 -0400
Received: by mail-pa0-f68.google.com with SMTP id k3so11524023pav.3
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 00:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=wn7ro6+WW2UMZKDqmXZPLT5Xu6mL5aUIgFsKlgS1EBI=;
        b=Ds/+2VL7BfJ8JhARFWHDqk33DgJOtTW8K2XSzallq5eUeeQnBOtSrDZ6dfAeS5qAV8
         y+MzyAmZX++wzFiPlbzRe7Q24+hoHWGmNvDcZUnRkjTjZ34mwOCAA208CNQYBJdsciNB
         EdOOtQEGpEPGuNFztnFAtiWK1VNcqJqamq+quwoGy1AFhqhuRcMiiVMx39LBn4tY9CW/
         j3pUEsPrGaRsm1J7xU64/SObysjhwfdyaBOEkiGiuGJVd4XTRM8RJCd/USbYdmXYAo9j
         xO0wv8xpKgljnCINvpeB/i1FVRfYkJqinfN7x7FYTUaJovw0JjASTqjlwPz8Zb3hATtO
         tqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=wn7ro6+WW2UMZKDqmXZPLT5Xu6mL5aUIgFsKlgS1EBI=;
        b=dWWIg69wIjdDAM/odiS25l8ORk+3zJqH3wOyM7gv//zJab2akqpt8Eu2imcZOEyIpU
         kJ6MAOXz0PyEDeKqIz5qpzIBz6FuVi564JBHHt37bliu+mYWH7l79SbfzE00M5WQmiom
         16rSePeT/24c6UivfaaXzvQSvk4np5OJiSTzRc9IUdvn7AJ2HskFpQ+F7zfCsHIFe7yd
         t8lZGlA02xzqUJSjGjwPnZztJg03Thxz9g9rIHySv0qV3G97aHmN60jmWKtqD2guUSTW
         fspuGR8/Q93Z4yUl00F2eHgd1RkcALOu6IGToJmUEGYWKZrt3CEU7FBR9ImsRwT7oTc+
         TCOQ==
X-Gm-Message-State: AOPr4FUyV9P/WxMJHLAyaozA/53wqJi+l841jBXzyyC/fft4gVDmI5PGMRv37IfMMPSgtQ==
X-Received: by 10.66.66.42 with SMTP id c10mr34893199pat.119.1460792825513;
        Sat, 16 Apr 2016 00:47:05 -0700 (PDT)
Received: from [192.168.1.10] ([122.162.75.130])
        by smtp.gmail.com with ESMTPSA id a86sm28761565pfc.42.2016.04.16.00.47.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Apr 2016 00:47:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CAEC5eqHEVr=k+UP8vG20L8Si-phYwZ5TLFr_dch=9_vM-99gYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291716>

Hi,
When thinking of a mascot for Git, the image of a cherry tree pops up in my
head. I'd think of a simple and elegant caricature of a tall tree (just like git
histories tend to get long) with a couple of branches and some cherries (think
cherry-pick) hanging around in the lush green crown. Perhaps wearing green
gloves and hands on waist, with big dark eyes and a smile. IMHO, it might be a
good  idea to let the mascot have a simple and minimal design instead of
intricate detailing as it would be both easier remember and easier for
production. Also, I'm not a _very_ good sketch artist, but I think I can make
some basic sketches for this one.

Regards,
Sidhant 
