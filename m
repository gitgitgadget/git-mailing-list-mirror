From: Claudio Scordino <cloud.of.andor@gmail.com>
Subject: Hook after pull ?
Date: Wed, 11 Jul 2007 16:41:19 +0200
Message-ID: <4694EC0F.10003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 16:41:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8dNr-00077d-DO
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 16:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761343AbXGKOlf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 10:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760736AbXGKOlf
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 10:41:35 -0400
Received: from ms01.sssup.it ([193.205.80.99]:45198 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758713AbXGKOle (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 10:41:34 -0400
Received: from [193.205.82.7] (HELO gandalf.sssup.it)
  by sssup.it (CommuniGate Pro SMTP 4.1.8)
  with ESMTP-TLS id 31861360; Wed, 11 Jul 2007 16:32:41 +0200
Received: from [10.30.3.110] ([10.30.3.110])
	by gandalf.sssup.it (8.12.10/8.12.10) with ESMTP id l6BDcSqi029781;
	Wed, 11 Jul 2007 15:38:28 +0200
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52164>

Hi all.

Does any hook being called after the pull (that means, after fetch or merge) ?

If no, does exist any easy way of creating such hook ?

Many thanks in advance,

           Claudio
