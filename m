From: Patricia Bittencourt Egeland <pbegeland@linea.gov.br>
Subject: tags not present in bare clone
Date: Mon, 23 Apr 2012 11:28:32 -0600
Message-ID: <0BE9553B-C799-43D5-BA9A-28FC83CA0773@linea.gov.br>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 20:02:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMNap-0001wK-TF
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 20:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611Ab2DWSCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 14:02:12 -0400
Received: from mailout06.yourhostingaccount.com ([65.254.253.50]:33982 "EHLO
	mailout06.yourhostingaccount.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751637Ab2DWSCL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 14:02:11 -0400
X-Greylist: delayed 2008 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Apr 2012 14:02:11 EDT
Received: from mailscan11.yourhostingaccount.com ([10.1.15.11] helo=mailscan11.yourhostingaccount.com)
	by mailout06.yourhostingaccount.com with esmtp (Exim)
	id 1SMN43-0007Tu-QC
	for git@vger.kernel.org; Mon, 23 Apr 2012 13:28:39 -0400
Received: from impout01.yourhostingaccount.com ([10.1.55.1] helo=impout01.yourhostingaccount.com)
	by mailscan11.yourhostingaccount.com with esmtp (Exim)
	id 1SMN42-0005Rq-H9
	for git@vger.kernel.org; Mon, 23 Apr 2012 13:28:38 -0400
Received: from authsmtp11.yourhostingaccount.com ([10.1.18.11])
	by impout01.yourhostingaccount.com with NO UCE
	id 1VUe1j00C0EKrUA01VUe3m; Mon, 23 Apr 2012 13:28:38 -0400
X-Authority-Analysis: v=2.0 cv=aoEw+FlV c=1 sm=1
 a=rUXlng4hSbeDE9+cSRnJPw==:17 a=Qa21fcannPsA:10 a=7gZlF70TDE0A:10
 a=kj9zAlcOel0A:10 a=FyW4_Oqtx48yLS1jYCIA:9 a=CjuIK1q_8ugA:10
 a=5bnIr+R+vs56oWgm0tidcA==:117
X-EN-OrigOutIP: 10.1.18.11
X-EN-IMPSID: 1VUe1j00C0EKrUA01VUe3m
Received: from [153.90.103.91]
	by authsmtp11.yourhostingaccount.com with esmtpa (Exim)
	id 1SMN3u-0008Kb-R0
	for git@vger.kernel.org; Mon, 23 Apr 2012 13:28:32 -0400
X-Mailer: Apple Mail (2.1084)
X-EN-UserInfo: 957f87d35c43172285e6793414996149:be26a490d08ddddd1ae22626b86f1c91
X-EN-AuthUser: patricia@egeland.us
X-EN-OrigIP: 153.90.103.91
X-EN-OrigHost: unknown
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196152>

Hi,

       I'm trying to create a bare clone from a regular repo (all locally; in the same machine). However a tag created in the regular repo can't be found in the fresh bare clone.
       I expected that the tags would also be present just like anything from "refs". Am I wrong about that? 

Thanks,
Patricia
