From: Lars Noschinski <lars-2008-1@usenet.noschinski.de>
Subject: Re: What's in git.git (stable)
Date: Sun, 20 Jul 2008 11:20:34 +0000 (UTC)
Message-ID: <20080720112034.GA27984@lars.home.noschinski.de>
References: <7vwsknyz9m.fsf@gitster.siamese.dyndns.org> <7vlk0z9k5f.fsf@gitster.siamese.dyndns.org> <7vej6oipea.fsf@gitster.siamese.dyndns.org> <7vabh93lk6.fsf@gitster.siamese.dyndns.org> <7vwsk4g5py.fsf@gitster.siamese.dyndns.org> <7vr6a7fhwh.fsf@gitster.siamese.dyndns.org> <7v1w25xfd6.fsf@gitster.siamese.dyndns.org> <7vmykljahl.fsf@gitster.siamese.dyndns.org> <7vabgiwlj5.fsf@gitster.siamese.dyndns.org> <7vwsjhgvtn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 13:21:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKWz0-0000ei-Qy
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 13:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024AbYGTLUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 07:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755863AbYGTLUo
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 07:20:44 -0400
Received: from main.gmane.org ([80.91.229.2]:59677 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754556AbYGTLUn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 07:20:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KKWy1-0000N1-Ol
	for git@vger.kernel.org; Sun, 20 Jul 2008 11:20:41 +0000
Received: from p3ee23420.dip0.t-ipconnect.de ([62.226.52.32])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 11:20:41 +0000
Received: from lars-2008-1 by p3ee23420.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 11:20:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p3ee23420.dip0.t-ipconnect.de
Content-Disposition: inline
In-Reply-To: <7vwsjhgvtn.fsf@gitster.siamese.dyndns.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89184>

* Junio C Hamano <gitster@pobox.com> [08-07-20 03:59]:
>Lars Noschinski (2):
>  cvsserver: Add support for packed refs
>  cvsserver: Add cvs co -c support

Any specific reason why you did not merge the test for packed refs
support? Was it considered superfluous?
