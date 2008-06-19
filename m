From: "D. Stuart Freeman" <stuart.freeman@et.gatech.edu>
Subject: Best practice question
Date: Thu, 19 Jun 2008 10:32:35 -0400
Message-ID: <485A6E03.6090509@et.gatech.edu>
Reply-To: stuart.freeman@et.gatech.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050900010408070607050404"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 16:34:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9LDN-0007da-By
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 16:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758814AbYFSOcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 10:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756001AbYFSOcn
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 10:32:43 -0400
Received: from deliverator2.ecc.gatech.edu ([130.207.185.172]:35674 "EHLO
	deliverator2.ecc.gatech.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758772AbYFSOch (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2008 10:32:37 -0400
Received: from deliverator2.ecc.gatech.edu (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id ED5D65C8855
	for <git@vger.kernel.org>; Thu, 19 Jun 2008 10:32:36 -0400 (EDT)
Received: from mailprx3.gatech.edu (mailprx3.prism.gatech.edu [130.207.171.17])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.mail.gatech.edu", Issuer "Equifax" (verified OK))
	by deliverator2.ecc.gatech.edu (Postfix) with ESMTP id 938675C883E
	for <git@vger.kernel.org>; Thu, 19 Jun 2008 10:32:36 -0400 (EDT)
Received: from [130.207.46.56] (cetel-004-xx6.admin.gatech.edu [130.207.46.56])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	(sasl: method=PLAIN, username=dfreeman31@mailprx3.gatech.edu, sender=n/a)
	by mailprx3.gatech.edu (Postfix) with ESMTP id 5C3AC1F84
	for <git@vger.kernel.org>; Thu, 19 Jun 2008 10:32:36 -0400 (EDT)
	(envelope-from stuart.freeman@et.gatech.edu)
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85480>

This is a multi-part message in MIME format.
--------------050900010408070607050404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

My project has an "about" page that lists the version.  I understand why
git doesn't do keyword expansion, but I'm wondering if there's a
recommended best practice for keeping that up to date.

-- 
D. Stuart Freeman
Georgia Institute of Technology

--------------050900010408070607050404
Content-Type: text/x-vcard; charset=utf-8;
 name="stuart_freeman.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="stuart_freeman.vcf"

begin:vcard
fn:D. Stuart Freeman
n:Freeman;Douglas
email;internet:stuart.freeman@et.gatech.edu
tel;work:(404)385-1473
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------050900010408070607050404--
