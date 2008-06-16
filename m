From: "D. Stuart Freeman" <stuart.freeman@et.gatech.edu>
Subject: Newbie question about making a bare repository
Date: Mon, 16 Jun 2008 14:57:42 -0400
Message-ID: <4856B7A6.50508@et.gatech.edu>
Reply-To: stuart.freeman@et.gatech.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060307010309050602040007"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:59:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Jum-0001Aj-20
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 20:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbYFPS5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 14:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752725AbYFPS5w
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 14:57:52 -0400
Received: from deliverator2.ecc.gatech.edu ([130.207.185.172]:38285 "EHLO
	deliverator2.ecc.gatech.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752380AbYFPS5w (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2008 14:57:52 -0400
Received: from deliverator2.ecc.gatech.edu (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 649C74801F2
	for <git@vger.kernel.org>; Mon, 16 Jun 2008 14:57:51 -0400 (EDT)
Received: from mailprx2.gatech.edu (mailprx2.prism.gatech.edu [130.207.171.21])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.mail.gatech.edu", Issuer "Equifax" (verified OK))
	by deliverator2.ecc.gatech.edu (Postfix) with ESMTP id 56BFE4801FE
	for <git@vger.kernel.org>; Mon, 16 Jun 2008 14:57:44 -0400 (EDT)
Received: from [130.207.46.56] (cetel-004-xx6.admin.gatech.edu [130.207.46.56])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	(sasl: method=PLAIN, username=dfreeman31@mailprx2.gatech.edu, sender=n/a)
	by mailprx2.gatech.edu (Postfix) with ESMTP id 096C71F7A
	for <git@vger.kernel.org>; Mon, 16 Jun 2008 14:57:44 -0400 (EDT)
	(envelope-from stuart.freeman@et.gatech.edu)
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85216>

This is a multi-part message in MIME format.
--------------060307010309050602040007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I have a repository that I made with 'git-svn clone' that I'd like to
make bare but retain the svn info.  Would I just change the "bare" in
.git/config to true?  Is there anything I have to do to remove the
working copy info?

I plan to do this so that a co-worker and I can clone the git repo, and
push our changes back to it, and maintain the "proxy" to svn from that
central location.

-- 
D. Stuart Freeman
Georgia Institute of Technology

--------------060307010309050602040007
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


--------------060307010309050602040007--
