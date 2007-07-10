From: Jean-Christian de Rivaz <jc@eclis.ch>
Subject: I used git pull instead of stg pull !
Date: Tue, 10 Jul 2007 11:52:47 +0200
Message-ID: <469356EF.201@eclis.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 12:18:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8CnP-0002h0-UR
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 12:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757372AbXGJKSN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 06:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755858AbXGJKSM
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 06:18:12 -0400
Received: from www.eclis.ch ([144.85.15.72]:36849 "EHLO mail.eclis.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756244AbXGJKSM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 06:18:12 -0400
Received: from [10.192.57.55] (pub1.heig-vd.ch [193.134.216.2])
	by mail.eclis.ch (Postfix) with ESMTP id 29EF03F2149;
	Tue, 10 Jul 2007 11:53:09 +0200 (CEST)
User-Agent: IceDove 1.5.0.12 (X11/20070606)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52058>

Hi,

I have made the error to use the "git pull" command instead of the "stg 
pull" command. The "git pull" have been executed successfuly, but now 
stg seem to be confused:

stg pull -n
stg pull: local changes in the tree. Use "refresh" to commit them

stg new dummy -m "dummy"
stg new: HEAD and top are not the same. You probably committed
   changes to the tree outside of StGIT. If you know what you
   are doing, use the "refresh -f" command

How can I restore the archive to a normal state for stg ?

Best regards,
--
Jean-Christian de Rivaz
