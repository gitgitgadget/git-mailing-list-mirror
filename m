From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [question] how can i verify whether a local branch is tracking a 
	remote branch?
Date: Sun, 5 Apr 2009 12:32:29 +0200
Message-ID: <4d8e3fd30904050332w394cccbaq5b82d2a53ed357a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 12:34:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqPgF-0007pa-7i
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 12:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758491AbZDEKce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 06:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758338AbZDEKcd
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 06:32:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:27196 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758079AbZDEKcc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 06:32:32 -0400
Received: by fg-out-1718.google.com with SMTP id 16so116655fgg.17
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 03:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=/azJji5VqEOz9cGwRy7MwSOZzJXtw96EKNvfqDBSOjQ=;
        b=mo97KHnGCbmRm6YYfr46vaguZx9UFADy+3PayO/OQyQ6dswgKL+Kz5z+j+/CClBBSl
         1XI75ttdBTIMlSAUWi0eqfnlush3MR6FnFJOY130pgdoJ+Zvd6jWhOPzVhH8D5sCpRKt
         359ugOKVrOc4iADKQaDFU1txHmFG9sj/WOwNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=hBHOcu1phP/XvBpGTCW0o1SEW1Bubt0NlTWD382MFUTsZb6ZGE3vBWPXAv21gV53E7
         eNHxe/J/zkPzBEUHkIfKtKNJdyxhXDvQIRdY9E0R9Zo/6kC1j4SXYbb9AdhSyCvkKEUe
         jLwpmUMGCMoutPVYSONcJVYRG4B0R9XaJo7/w=
Received: by 10.86.65.9 with SMTP id n9mr2221372fga.55.1238927549803; Sun, 05 
	Apr 2009 03:32:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115655>

Hi all,
is there a way to verify, using the UI, whether a local branch is
tracking a remote branch?

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
http://mypage.vodafone.it/
