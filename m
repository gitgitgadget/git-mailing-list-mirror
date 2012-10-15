From: Elia Pinto <gitter.spiros@gmail.com>
Subject: When Will We See Collisions for SHA-1? (An interesting analysis by
 Bruce Schneier)
Date: Mon, 15 Oct 2012 18:42:29 +0200
Message-ID: <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Chacon <schacon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 18:42:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNnkW-0004iL-7r
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 18:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab2JOQmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 12:42:31 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:61854 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab2JOQm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 12:42:29 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so3813145iag.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 09:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=Cd8eNSXHBlxwpkQrNMRuakakXZis2gTUfAmDFF6MS0c=;
        b=AxSWjNCkVdyxhZ25Q//biygGd/L9QrHqmntcj3Z2X6+owstMDzPnH6VcQdDFwQETCs
         XgHZezuxYugPQxfqll5Il+ZWiHyhHbOteXezliwNB3A3OnELo+le8MKsvCQkveoUirgu
         5/wAVXrAwtJdcWJdXl+fS1+KmvDgX421SMm7MWDq08YyZ3aYopUcCEVYmzJO4KAq3WsP
         8KcbtGK5pwh48ahaj4Y67KtHANZa1WHH3XSKPgmc2M8eFikcVuNs2on5qpllzoCygUMo
         5GCTzOWNU0do5/ofEToTd7lfVSp4oe535ZsrHuzSPPfWbXAt9qhVuVO61538xCalPELJ
         tKFw==
Received: by 10.50.56.139 with SMTP id a11mr9251255igq.3.1350319349102; Mon,
 15 Oct 2012 09:42:29 -0700 (PDT)
Received: by 10.64.48.37 with HTTP; Mon, 15 Oct 2012 09:42:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207759>

Very clear analysis. Well written. Perhaps is it the time to update
http://git-scm.com/book/ch6-1.html (A SHORT NOTE ABOUT SHA-1) ?

Hope useful

http://www.schneier.com/crypto-gram-1210.html

Best Regards
