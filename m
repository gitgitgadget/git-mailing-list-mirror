From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: 66 patches and counting
Date: Wed, 05 Oct 2011 23:29:57 +0200
Message-ID: <4E8CCC55.9070408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 23:30:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBZ2S-0007Q7-5W
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 23:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432Ab1JEVaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 17:30:00 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:53560 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756259Ab1JEV37 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 17:29:59 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p95LTwkk007464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 5 Oct 2011 23:29:58 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182886>

My renovation of refs.c [1] is currently at 66 patches and counting.
What can I say?: (1) I like to make changes in the smallest irreducible
steps and (2) there is a lot that needed to be done in refs.c.

When I'm done, is it OK to dump a patch series like that on the git
mailing list?  Is it pointless because nobody will review them anyway?
Is a big pile of changes like this welcome in any form?  Would it be
better to convey the changes via git itself (e.g., github) rather than
via emails?

Michael

[1] hierarchical-refs at git://github.com/mhagger/git.git

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
