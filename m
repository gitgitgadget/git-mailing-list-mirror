From: Sergey Yanovich <ynvich@gmail.com>
Subject: git tool to keep a subversion mirror
Date: Sun, 17 Jun 2007 22:38:55 +0300
Message-ID: <11821091373273-git-send-email-ynvich@gmail.com>
To: git@vger.kernel.org, normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Sun Jun 17 21:38:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I00Zg-0004hm-1O
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 21:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760289AbXFQTiB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 15:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757759AbXFQTiA
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 15:38:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:37527 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107AbXFQTh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 15:37:58 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1243062ugf
        for <git@vger.kernel.org>; Sun, 17 Jun 2007 12:37:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=I1XAE0v0j9G54AfAG80typEn0IGTIBWsAQ/uF6UIhlASKFWbNSD1izz30SVRdodHM0fXOTx3Ew2A9R5H+cjMHDkyJ1acgJCayRzmFmVvl38jCR+UzEU2BIWS0CZEpirqXSiK3Ow2xpYk7V4FLFiquU8ibJExAaJd1vR7MjRu8GI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=if/h0c8hqN6I8uinOMBSPKlWOuvblUOHSqgJfCJfAVYSNDUOHl4YyvpmkAVBZlEzVHE4MiRKj9sb5J15n3R9CBw5f50AUD85mOgVP3mbv0Vmfz+miwZbpHjNH6NejrJKUZlenQvQcXJC4uwHL28FtxqNYtAa+mcBOsrWFLuD4lw=
Received: by 10.67.90.14 with SMTP id s14mr4451834ugl.1182109077630;
        Sun, 17 Jun 2007 12:37:57 -0700 (PDT)
Received: from host3 ( [87.252.237.202])
        by mx.google.com with ESMTP id e62sm4346807uge.2007.06.17.12.37.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Jun 2007 12:37:56 -0700 (PDT)
Received: from sergei by host3 with local (Exim 4.63)
	(envelope-from <ynvich@gmail.com>)
	id 1I00aP-0002mm-S8; Sun, 17 Jun 2007 22:38:57 +0300
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: 11821061823423-git-send-email-ynvich@gmail.com
References: 11821061823423-git-send-email-ynvich@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50370>

Oops, failed to attach patches last time
