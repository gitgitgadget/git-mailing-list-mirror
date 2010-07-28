From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Possible feature request for merge and pull
Date: Tue, 27 Jul 2010 21:24:25 -0400
Message-ID: <AANLkTim6JAPrSVaSaGZ72xtfFnUUcYeWT8vpL3rYuwki@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 28 03:24:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdvNt-0008BQ-3J
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 03:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920Ab0G1BY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 21:24:27 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52479 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768Ab0G1BYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 21:24:25 -0400
Received: by pvc7 with SMTP id 7so684055pvc.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 18:24:25 -0700 (PDT)
Received: by 10.142.223.14 with SMTP id v14mr11349567wfg.44.1280280265263; 
	Tue, 27 Jul 2010 18:24:25 -0700 (PDT)
Received: by 10.142.98.16 with HTTP; Tue, 27 Jul 2010 18:24:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152027>

I would love to be able to use the -m flag and --log together with git
merge and pull to be able to create a custom commit message but also
include one-line summaries of each of the commits being merged/pulled.
