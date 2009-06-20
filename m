From: David Christensen <david@endpoint.com>
Subject: Feature suggestion: git grep --blame
Date: Sat, 20 Jun 2009 10:29:28 -0500
Message-ID: <B13F8D3F-E69B-49BA-9B81-27DF19E33A43@endpoint.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 20 17:57:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MI2wI-000265-54
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 17:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058AbZFTP4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 11:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753774AbZFTP4m
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 11:56:42 -0400
Received: from mail.endcrypt.com ([74.205.105.202]:50702 "EHLO
	mail.endcrypt.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbZFTP4l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 11:56:41 -0400
X-Greylist: delayed 1635 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jun 2009 11:56:41 EDT
Received: from [192.168.0.4] (adsl-65-71-168-123.dsl.tpkaks.swbell.net [65.71.168.123])
	by mail.endcrypt.com (Postfix) with ESMTP id CF74330D5D
	for <git@vger.kernel.org>; Sat, 20 Jun 2009 15:29:28 +0000 (UTC)
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121945>

Hey folks,

It's occurred to me on several occasions that a useful output option  
for `git grep` would be to prefix lines with the same commit/author/ 
date annotation that `git blame` shows when viewing an individual  
file.  I didn't find anything myself with a quick google search so I  
was wondering if anyone a) has a recipe for this either with a trivial  
command alias (I couldn't come up with one myself), b) know if this  
has been done/attempted before, or c) have a reason why this is a  
really stupid idea? :-)

Regards,

David
--
David Christensen
End Point Corporation
david@endpoint.com
