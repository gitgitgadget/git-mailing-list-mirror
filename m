From: "Alfonsogonzalez, Ernesto (GE Digital)" 
	<ernesto.alfonsogonzalez@ge.com>
Subject: bug: incorrect plurality of "commit" in git status
Date: Mon, 2 May 2016 22:46:10 +0000
Message-ID: <2A734D896A45164C887E476E942BF4F9B5F721@CINMBCNA09.e2k.ad.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 01:45:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axNXI-0005Qf-QC
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 01:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbcEBXpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 19:45:53 -0400
Received: from mx0a-00176a03.pphosted.com ([67.231.149.52]:7281 "EHLO
	mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932274AbcEBXpw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 May 2016 19:45:52 -0400
X-Greylist: delayed 3570 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 May 2016 19:45:52 EDT
Received: from pps.filterd (m0047963.ppops.net [127.0.0.1])
	by m0047963.ppops.net-00176a03. (8.16.0.11/8.16.0.11) with SMTP id u42MgENX008969
	for <git@vger.kernel.org>; Mon, 2 May 2016 18:46:21 -0400
Thread-Topic: incorrect plurality of "commit" in git status
Thread-Index: AQHRpMRrexs8XJcjokiZgcMkUVMUmA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [3.159.212.84]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2016-05-02_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1603290000
 definitions=main-1605020354
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293306>


[debian-vm]$ gt
On branch feat/junit-test
Your branch and 'origin/feat/junit-test' have diverged,
and have 19 and 1 different commit each, respectively.



Should be "commits"