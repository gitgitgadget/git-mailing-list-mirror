From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Feb 2016, #04; Fri, 12)
Date: Sun, 14 Feb 2016 13:22:26 +0100
Message-ID: <56C07182.1040804@web.de>
References: <xmqqfuwxtrni.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 14 13:22:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUvhR-0001cL-QC
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 13:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbcBNMWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 07:22:46 -0500
Received: from mout.web.de ([212.227.17.11]:59934 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbcBNMWp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 07:22:45 -0500
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LfzxX-1aC3E23vat-00pcEQ; Sun, 14 Feb 2016 13:22:34
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <xmqqfuwxtrni.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:0lfGEQprZyYhku0qjy8ly9UNb/asspSSsF3UFKlBCBl7lVv4YOm
 ayuA1lW6iVRDPlkWkdRJZlh+ogmL8gJLaS1qYvyVDFZz3s0pMySXABVckqCZuBuOFP5Y0Ph
 I1YcccWkrqky1RDvTZl5E8s00amvsUjwOoom6ngq7ei7QYhOf7738gCdLT3bPti9pmEoJBV
 1ZfCeWDQXD0rbRleyg/vg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v/Vh5MW4DU0=:9FeeVtwO5I+Wq6KlbFE+Uy
 JAFEQrdKDxKkvo0g0yaafTuCLlHcn+FG8EgZ10e+Jr+7cfDi5yXYKEcR8ZG7NZsdgWdrbeZTI
 GgyKF6GAgvnAjb/9Gf+48A64C/365drJa7iKLALtGsfN4KvhRLP5/7F9xKlKDVrdHLHpy2363
 K/E9YVSXOSfrgVetT8OJ+6Yqp3KEvxsteooX0VlJJbYlEORfAmpWRbI+HT5vzwaSrI2NR3k8q
 uQKHrMqOnDFq44ZbceyynHnMeJYC4Gliynd6FfL7ptTEVW0k+bcXGlDi/aQpBQGkzWQc+77mF
 eDTjbSHJEs2SRIGuNGrIKU0eE6LxD/28C5csAiZS/pxyjTgAYDA8O16GKdSOfvl6Mu8pZ0QrB
 lx6PnGgpTZOThDoAIPXbbHQjds000D6+X9FHdomFdgvDiH90IImVkGZ/tpj1XL4D4U8y+I38z
 ABDvrk3jIjNPvD+8TgfGtzcEgvg6ynQqFRN6IgWriui4HvnilAFf5N2+heXhixUhmX3aZpFH9
 YpfzWzReQZsoht3Vv/yXyb+PFelRLdQoiK9E+UC43xq9+fkVqP9RthY/uhtNwGHAeUnPHYxgq
 QZP0Fdk5ipf2o2lt4UgQyHQiOIyyMRVMRYd8V+knOWnJxcA+OE+X42pM915i0wYHTYcjRQK8h
 Hn7GXa8TX6wBbj75SWJFlAmh2aFGRpoESu7OayJi/pcLASERG8kQeThPjh9CK9xuV+Q8pTIQ6
 oCzvR2KsFkQqGSBHT0Kz29JrW4MA4kSId/UGMPq5XI7YqWnt1B56lf2EyNc6g4YfCDFG9+cN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286150>

> * tb/conversion (2016-02-10) 6 commits
>   (merged to 'next' on 2016-02-12 at 6faf27b)
Could we keep it in next for a while ?

I found issues that needs to be fixed before going to master,
updates follow soonish.
Thanks
