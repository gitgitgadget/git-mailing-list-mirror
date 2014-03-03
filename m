From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: My advice for GSoC applicants
Date: Mon, 03 Mar 2014 11:45:28 +0100
Message-ID: <53145D48.3040603@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dmitry Dolzhenko <dmitrys.dolzhenko@yandex.ru>,
	Sun He <sunheehnus@gmail.com>,
	Brian Gesiak <modocache@gmail.com>,
	Tanay Abhra <tanayabh@gmail.com>,
	Kyriakos Georgiou <kyriakos.a.georgiou@gmail.com>,
	Siddharth Goel <siddharth98391@gmail.com>,
	Guanglin Xu <mzguanglin@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Alberto Corona <albcoron@gmail.com>,
	Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 11:45:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKQNV-000717-OJ
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 11:45:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbaCCKph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 05:45:37 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61521 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754061AbaCCKpe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 05:45:34 -0500
X-AuditID: 1207440f-f79326d000003c9f-ae-53145d4d5394
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 12.1D.15519.D4D54135; Mon,  3 Mar 2014 05:45:33 -0500 (EST)
Received: from [192.168.69.148] (p57A2466F.dip0.t-ipconnect.de [87.162.70.111])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s23AjTJ2004894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 3 Mar 2014 05:45:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsUixO6iqOsbKxJssGemmEXD9pWMFge3nma3
	6LrSzWSxfP4aFovZWzawWbyevpzd4tfhJ+wWa/bNZbN4evcGs0Xb7e2MFr8uvGd24PbYOesu
	u8fnTXIehxv6WQKYo7htkhJLyoIz0/P07RK4M9Zd7mEtmMNSsfvUQfYGxj3MXYycHBICJhI/
	Vy9lgbDFJC7cW8/WxcjFISRwmVHi6/wZLBDOOSaJa28+g1XxCmhLnNu8iBXEZhFQlVi0bz4j
	iM0moCuxqKeZCcQWFQiWWH35AVS9oMTJmU/AbBGgml3ProJtYBZ4xCzxb88KsGZhATWJB2cP
	Ap3EAXSGuERPYxBImFlAR+Jd3wNmCFteYvvbOcwTGPlnIRk7C0nZLCRlCxiZVzHKJeaU5urm
	JmbmFKcm6xYnJ+blpRbpmujlZpbopaaUbmKEhD3/Dsau9TKHGAU4GJV4eA2WCgcLsSaWFVfm
	HmKU5GBSEuX1iREJFuJLyk+pzEgszogvKs1JLT7EKMHBrCTCmxsOlONNSaysSi3Kh0lJc7Ao
	ifOqL1H3ExJITyxJzU5NLUgtgsnKcHAoSfCqgAwVLEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJ
	LUosLcmIB8VkfDEwKkFSPEB7DUDaeYsLEnOBohCtpxh1OW63/frEKMSSl5+XKiXOuzsaqEgA
	pCijNA9uBSzJvWIUB/pYmNceZBQPMEHCTXoFtIQJaImZH9iSkkSElFQD4/Q3DCoBjWLqTPeF
	E29ecFC2ixaoUDrq/Xlt07Ivoo7/VyZUOsTaH5j5tuOey+U2nu5v7K4PrPlbjgVO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243219>

Hi,

Based on my experience so far as a first-time Google Summer of Code
mentor, I just wrote a blog article containing some hopefully useful
advice for students applying to the program.  Please note that this is
my personal opinion only and doesn't necessarily reflect the views of
the Git/libgit2 projects as a whole.

    My secret tip for GSoC success

http://softwareswirl.blogspot.com/2014/03/my-secret-tip-for-gsoc-success.html

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
