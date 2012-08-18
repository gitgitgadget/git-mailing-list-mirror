From: mhagger@alum.mit.edu
Subject: [PATCH 0/2] Fix two minor problems in the docs for git-config
Date: Sat, 18 Aug 2012 19:32:08 +0200
Message-ID: <1345311130-20426-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 19:36:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2mx9-0008M6-1G
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 19:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756551Ab2HRRgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 13:36:41 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:49118 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756669Ab2HRRcb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Aug 2012 13:32:31 -0400
X-AuditID: 1207440f-b7fde6d00000095c-3c-502fd1aea168
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 9E.36.02396.EA1DF205; Sat, 18 Aug 2012 13:32:30 -0400 (EDT)
Received: from michael.fritz.box (p57A25507.dip.t-dialin.net [87.162.85.7])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7IHWF9p002696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 18 Aug 2012 13:32:29 -0400
X-Mailer: git-send-email 1.7.11.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsUixO6iqLvuon6Awaw+DouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M44ee4jY8FBporlby6wNDA2
	MXUxcnBICJhI/D3v38XICWSKSVy4t56ti5GLQ0jgMqPEqa0LmCCc00wSq093sIBUsQlISbxs
	7GEHsUUE1CQmth0CizMLOEhs/tzICGILC7hJ/D9zkQ3EZhFQlVi5dDZYPa+Ai0TfncesENsU
	JX58X8M8gZF7ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdE73czBK91JTSTYwQ3/PvYOxa
	L3OIUYCDUYmHV2GNXoAQa2JZcWXuIUZJDiYlUd73Z/QDhPiS8lMqMxKLM+KLSnNSiw8xSnAw
	K4nw6p4AKudNSaysSi3Kh0lJc7AoifOqL1H3ExJITyxJzU5NLUgtgsnKcHAoSfDuuAA0VLAo
	NT21Ii0zpwQhzcTBCSK4QDbwAG04AVLIW1yQmFucmQ5RdIpRUUqcdxtIQgAkkVGaBzcAFqWv
	GMWB/hHmvQpSxQOMcLjuV0CDmYAGrxTRBRlckoiQkmpgdI2e2zR/kVXlcsmnjnHXDYOKoxiX
	FD8v/7XDu2GnRdOchrhZtjYeirJCqU0H/nxR2bZr7pJQy7N3d0nKPYrp0HrELepdPouTOaP4
	9GTmvx4XVv7Qvay0NyX/y8E14T4NLZNjAmbuupTHE2ebmyG1Rcx+ubepQWzdvCCllNWcWULC
	V64ezahUYinOSDTUYi4qTgQAhFKKVa0CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203681>

From: Michael Haggerty <mhagger@alum.mit.edu>

This is just something I stumbled across.

Michael Haggerty (2):
  git-config.txt: properly escape quotation marks in example
  git-config.txt: fix example

 Documentation/git-config.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.7.11.3
