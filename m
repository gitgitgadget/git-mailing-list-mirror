From: Dave Zarzycki <zarzycki@apple.com>
Subject: Re: Resend: [PATCH] Do not log unless all connect() attempts fail
Date: Tue, 12 Jul 2011 09:29:33 -0700
Message-ID: <A10BFC0E-05BB-41CF-BC86-28D3FF4CC7A8@apple.com>
References: <A3C89B89-4E31-400E-9DF8-C0F289D72D81@apple.com>
 <7v39iba3b2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 18:29:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgfq6-0004kZ-Qx
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 18:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab1GLQ3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 12:29:34 -0400
Received: from honeycrisp.apple.com ([17.151.62.51]:56293 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab1GLQ3e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 12:29:34 -0400
Received: from relay11.apple.com ([17.128.113.48])
 by mail-out.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTPS id <0LO8007KJB4XF0R0@mail-out.apple.com> for git@vger.kernel.org;
 Tue, 12 Jul 2011 09:29:33 -0700 (PDT)
X-AuditID: 11807130-b7c45ae000001381-c3-4e1c763fa053
Received: from jimbu (jimbu.apple.com [17.151.62.37])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay11.apple.com (Apple SCV relay)
 with SMTP id 19.E6.04993.F367C1E4; Tue, 12 Jul 2011 09:28:47 -0700 (PDT)
Received: from davez.apple.com (davez.apple.com [17.226.34.35])
 by cardamom.apple.com
 (Oracle Communications Messaging Exchange Server 7u4-20.01 64bit (built Nov 21
 2010)) with ESMTPSA id <0LO800D4XB3N1Q10@cardamom.apple.com> for
 git@vger.kernel.org; Tue, 12 Jul 2011 09:29:33 -0700 (PDT)
In-reply-to: <7v39iba3b2.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1244.3)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsUiON1OVde+TMbP4M4qYYuuK91MDowenzfJ
	BTBGcdmkpOZklqUW6dslcGWcbJ/BWPCdseLT7MlMDYz7GbsYOTkkBEwkpmz4xQphi0lcuLee
	rYuRi0NIoJVJ4vCpXewgCV4BQYkfk++xdDFycDALyEscPC8LEmYW0JL4/qiVBaJ+BZPEmTsv
	mEFqhAW8JHbsTgWpYRPQkPh06i4ziM0pYCYxY/MNMJtFQFXi6q4V7BBzxCXWzT0PtcpG4s2h
	3WC2kECGxPl5u5hAbBEBNYmJbYdYIO6Ul1jc8plxAqPALCTXzUK4bhaS6xYwMq9iFCxKzUms
	NDTUSywoyEnVS87P3cQICrqGQoMdjGt/8h9iFOBgVOLhLUyU8RNiTSwrrsw9xCjBwawkwmtj
	DBTiTUmsrEotyo8vKs1JLT7EKM3BoiTO+8xW2k9IID2xJDU7NbUgtQgmy8TBKdXAaM5s37og
	vo0/VbX4uffe/ful3z2s9Y3IEXV9VyiruVBboaTFS+5L4nYuq7Y1VsusZQxSK+4ULdq7KyZj
	6b/Ion/u2/4t2PplonkNX+zf9X/tLkgFiUkrxlycws2582zY+yWcdclTfXYuanrMEO/4cmv4
	LzVujm2lm6cFbb2xWPiBnMci+6OPlViKMxINtZiLihMB+bux4DYCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176947>

Sure, no problem-o. (Sorry, I should have read the submitting patches document first.) Thanks again!


On Jul 12, 2011, at 9:09 AM, Junio C Hamano wrote:

> This looks Looks good to me; could you sign-off the patch, please?
> 
> Thanks.
