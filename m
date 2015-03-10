From: Koosha Khajehmoogahi <koosha.khajeh@gmail.com>
Subject: Clarification required for microproject "Add configuration options
 for some commonly used command-line options"
Date: Wed, 11 Mar 2015 00:29:39 +0100
Message-ID: <54FF7E63.3030902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 00:30:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVTbg-0003BQ-Dr
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 00:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbbCJXac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 19:30:32 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34162 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbbCJXab (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 19:30:31 -0400
Received: by wiwl15 with SMTP id l15so32564268wiw.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 16:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=/5HX2bzJmapL/QeISIkZN3iVV3HziwL3zTgiPl7zJVk=;
        b=m/tF0hMBWMt9KtLuKyrl2TZzwwf6rWgM4BLD6Q+Uz6RE12rC5Dsflr1KJyu7FsOLI/
         69Tze9QKl6VbxLRk1JARDgKSsdlQc+qlsUDRRV36joL08CB+S/9SpLnCs8M2e/4AWi+V
         TUm5kWV0lNErUasdbTKbp7n9QUqGL7tc1V5C5CGpRZ+elTARuSOGnYcIiJuSZlSngy8D
         cHAimDEzQRY6vXEWKxeMnl1T9RVe4qBK6y5mAM8FhSx89UdoKb7MWDfE2tvPGzc8pWXf
         5PoGNPEI2h2DngPzqcldK600qSANljx5+9nyJpMcHwYhsmZVQcWNVzaxiNY2tvYRV58c
         pCjQ==
X-Received: by 10.194.177.132 with SMTP id cq4mr69676594wjc.99.1426030230310;
        Tue, 10 Mar 2015 16:30:30 -0700 (PDT)
Received: from [10.148.69.170] (host135-2.natpool.mwn.de. [138.246.2.135])
        by mx.google.com with ESMTPSA id bd1sm22299484wib.13.2015.03.10.16.30.29
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2015 16:30:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265283>

Does this microproject require the feature to be a generic one for every
possible command or should it be limited to some particular commands?
