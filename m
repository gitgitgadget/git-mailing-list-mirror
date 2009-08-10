From: Thomas Koch <thomas@koch.ro>
Subject: [Feature Request] git export
Date: Mon, 10 Aug 2009 18:22:59 +0200
Message-ID: <200908101822.59940.thomas@koch.ro>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 18:23:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaXeX-0005nC-1k
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 18:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641AbZHJQXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 12:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755635AbZHJQXI
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 12:23:08 -0400
Received: from koch.ro ([93.90.184.107]:54284 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755538AbZHJQXH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2009 12:23:07 -0400
Received: from 84-72-56-244.dclient.hispeed.ch ([84.72.56.244] helo=jona.localnet)
	by ve825703057.providerbox.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1MaXeK-0006UC-K1
	for git@vger.kernel.org; Mon, 10 Aug 2009 18:23:04 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.29-1-amd64; KDE/4.3.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125481>

could you please provide a simple solution to save a tree object into an 
arbitrary location?
I found some hints, that it would be possible by missusing either git 
checkout-index or git-archive, but I think that it shouldn't require that much 
GIT FU to do such a simple thing.

Thanks,

Thomas Koch, http://www.koch.ro
