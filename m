From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: git diff does not precompose unicode file paths (OS X)
Date: Tue, 15 Mar 2016 06:45:53 +0100
Message-ID: <56E7A191.7070302@web.de>
References: <0008C25D-C3F0-4A1F-8B50-4EF1E84CA04F@fournova.com>
 <56D97C8C.1060205@web.de> <D9E0FEEC-1987-4045-AD0F-4C7C76DC067B@fournova.com>
 <56D9D8C6.2060104@ramsayjones.plus.com>
 <8C785DB2-CEDB-435B-945B-00E4D98DBF99@fournova.com> <56DD41D5.60100@web.de>
 <5C6A30EF-ED0A-4D64-B971-CF873C64B46E@fournova.com> <56DEC5DD.2070407@web.de>
 <A81BB0E5-4879-4A86-9019-BB76734BA9EF@fournova.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Alexander Rinass <alex@fournova.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershause?= =?UTF-8?Q?n?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 15 06:46:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afho1-000691-3q
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 06:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752820AbcCOFqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 01:46:04 -0400
Received: from mout.web.de ([212.227.15.14]:54621 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969AbcCOFqC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 01:46:02 -0400
Received: from [192.168.88.158] ([194.47.243.242]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LnjNH-1aB4kH2GpL-00hrx8; Tue, 15 Mar 2016 06:45:54
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <A81BB0E5-4879-4A86-9019-BB76734BA9EF@fournova.com>
X-Provags-ID: V03:K0:SN7YmzZnW27nKaiC98UXEeNP+e3DNL6sYDJDWaT+H2uV3EFPMQy
 h69P7bhwH1ag70yDhbD/HqTYu7fiRzBmmh099UQozsQXCqvj6JlYQ6fV8BInnhcKnKRvxIE
 g5xUeiAXqfyWbMhkIclTan7LHIiHmh8hd3ugzp4WI9hFx5MOvTUdCGFaY81fyUs8yDGrgy4
 4vGHElOigZiZJbNL5emBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NC1hsAFEQuY=:/feg0ocl2Xwkag7R4ZhH7o
 Rq3LWWH+C87Ut2ZoQ+D8BzQF/0wbU4+0SdQcWNaYGd3XU0FdNnEPIyN60SoA01C5zRubkDBG9
 aIPeA9zPEyKpsb7Z6z3CFrSPABRrEkfeoT1a9YSNXuNKGtIW9f6jZJqwzNxBieeYVV8dqvjKS
 cq9BPKGHEZzj8z2tRdgbi9J3hxsS22etrk/b48r6mFfQZekcMrZczlsDSovFkYQ47wmk/PJ0g
 s2acHqSOZjD52pHVCAruoH+XC/eaG3lI2L8+AnTe5NCNDm4n/ZxCZ6tjCthPiFtw+EWScvs/8
 JYMGimn/AIObyu4ktd+r4S9sGg96/8fokY7kAAVT7frdhrFoZEjnjxHjb2SsC8Xv7JYIzk6Iz
 LA9bVt0DnjkN8xIF/Us5Sh18GPZULnV3ZTl19pZ6rkDM1XDQFaMJuAMqCrnjB+ETraf3bFeWC
 xyOopKBUNdVxrHn5bIi2PvTbuH/3ggs+ejENNLKmeZmM0nz7+lv45jw0H+uRefCmsWTIrTmG0
 LAJEljy4wSurBLO98LxYH508f1WwD3FTNAaFHkECjeZYtqGSR8vQcRGUzgdhiGzAcVK2zAC/w
 ZTJxcEmI/4FmiPmf27l9oZnMY/20GkozXy6bD3Um1PjvygcBYSPS90W6SI67uMVKxHKphCIHB
 reHrStZOeH9RNfVW2yXres48fKolQG4vb0G1U8+JN8DthBRSFV87NRCJg5SXSeTDJxVu4hVNM
 6qd/b2KDJdTkPNcjLmj5uGm8ifhHsV2Kj9DwrmcgHTf98TsphzTdnEvuJ5utIBNJlPtW/t93 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288833>

 >I created a test case but git diff exits with 0 if it does not recognize the 
file >path so the test case always succeeds. Can you give me a hint or one 
 >example test case?

The most clean (?) is to compare "git diff" NFC and git diff NFD, they should 
give the same result:
for "git diff" something like this would do:
+
+# This will test git diff
+test_expect_success "git diff f.Adiar" '
+       echo "Modified" >f.$Adiarnfd &&
+       git diff f.$Adiarnfd >expect &&
+       git diff f.$Adiarnfc >actual &&
+       git checkout f.$Adiarnfd &&
+       test_cmp expect actual
+'

HTH
/Torsten
