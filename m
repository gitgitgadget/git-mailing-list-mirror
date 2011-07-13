From: <Mathieu.Pogeant@renesasmobile.com>
Subject: Multiple projects with Gitweb
Date: Wed, 13 Jul 2011 13:10:37 +0000
Message-ID: <700B9246C3446949B8085B181F2C217804E59B@renexmb01.roe2.renesasmobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 13 15:10:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgzDC-0003um-13
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 15:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051Ab1GMNKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 09:10:41 -0400
Received: from mail216.messagelabs.com ([85.158.143.99]:17634 "EHLO
	mail216.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab1GMNKk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 09:10:40 -0400
X-VirusChecked: Checked
X-Env-Sender: Mathieu.Pogeant@renesasmobile.com
X-Msg-Ref: server-13.tower-216.messagelabs.com!1310562638!11446158!1
X-StarScan-Version: 6.2.17; banners=-,-,-
X-Originating-IP: [213.174.82.10]
Received: (qmail 31108 invoked from network); 13 Jul 2011 13:10:38 -0000
Received: from renexfe01.roe2.renesasmobile.com (HELO renexfe01.roe2.renesasmobile.com) (213.174.82.10)
  by server-13.tower-216.messagelabs.com with AES128-SHA encrypted SMTP; 13 Jul 2011 13:10:38 -0000
Received: from RENEXMB01.roe2.renesasmobile.com ([fe80::e58a:2b9f:54fe:ff5])
 by renexfe01.roe2.renesasmobile.com ([fe80::ec94:bbb3:68e:a94a%18]) with mapi
 id 14.01.0255.000; Wed, 13 Jul 2011 16:10:38 +0300
Thread-Topic: Multiple projects with Gitweb
Thread-Index: AcxBXjyEPerT1euQRWqUsYOOEgQeKw==
Accept-Language: fr-FR, da-DK, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.21.22.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177038>

Hello,

I'm trying to have this with GitWeb.
I have a repo under /project1 and a repo under /project2 on my Git server.
I would like to access these 2 repo via Gitweb like that: http://mygitserver/project1 and http://mygitserver/project2.
The problem is that gitweb.conf permit to use just one repo with directive $projectroot.

Did someone face the same problem?
If needed, I can share configuration file.
Best regards,
--
Mathieu POGEANT
