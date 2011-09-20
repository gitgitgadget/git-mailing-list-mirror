From: =?ISO-8859-15?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>
Subject: How to see 'assume-unchanged' information
Date: Tue, 20 Sep 2011 13:36:51 +0200
Message-ID: <4E787AD3.2000208@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 13:45:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5ylo-0004SA-31
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 13:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755435Ab1ITLpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 07:45:43 -0400
Received: from mail96.atlas.de ([194.156.172.86]:10503 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753351Ab1ITLpm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 07:45:42 -0400
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Sep 2011 07:45:42 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 0F85510091
	for <git@vger.kernel.org>; Tue, 20 Sep 2011 13:36:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id CY2Kkst7Bmaj for <git@vger.kernel.org>;
	Tue, 20 Sep 2011 13:36:51 +0200 (CEST)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP
	for <git@vger.kernel.org>; Tue, 20 Sep 2011 13:36:51 +0200 (CEST)
Received: from [141.200.19.108] (as112671.atlas.de [141.200.19.108])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 845192718B
	for <git@vger.kernel.org>; Tue, 20 Sep 2011 13:36:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181757>

Hi there.

Is it somehow possible to see which files have the 'assume unchanged'
bit set ?

Thx,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: To be, or not to be, those are the parameters.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
