From: Timothy Murphy <gayleard@eircom.net>
Subject: From git repository to server
Date: Fri, 22 Jan 2010 18:37:21 +0000
Organization: Trinity College Dublin
Message-ID: <201001221837.21862.gayleard@eircom.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 19:37:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYONw-0000sM-OP
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 19:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169Ab0AVSh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 13:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756159Ab0AVSh1
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 13:37:27 -0500
Received: from mail24.svc.cra.dublin.eircom.net ([159.134.118.53]:49009 "HELO
	mail24.svc.cra.dublin.eircom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756079Ab0AVSh0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 13:37:26 -0500
Received: (qmail 46505 messnum 11753106 invoked from network[86.43.71.228/unknown]); 22 Jan 2010 18:37:22 -0000
Received: from unknown (HELO localhost.localdomain) (86.43.71.228)
  by mail24.svc.cra.dublin.eircom.net (qp 46505) with SMTP; 22 Jan 2010 18:37:22 -0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.14.3/8.14.3) with ESMTP id o0MIbMmc020457
	for <git@vger.kernel.org>; Fri, 22 Jan 2010 18:37:22 GMT
Received: (from tim@localhost)
	by localhost.localdomain (8.14.3/8.14.3/Submit) id o0MIbLxX020456
	for git@vger.kernel.org; Fri, 22 Jan 2010 18:37:21 GMT
User-Agent: KMail/1.12.4 (Linux/2.6.31.9-174.fc12.i686; KDE/4.3.4; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137773>

I want to set up a GIT repository for a project on machine A ("alfred"),
but I'd like it to be accessible on my web-server B ("helen").
What is the simplest way to set this up?

-- 
Timothy Murphy  
e-mail: gayleard /at/ eircom.net
tel: +353-86-2336090, +353-1-2842366
s-mail: School of Mathematics, Trinity College, Dublin 2, Ireland
