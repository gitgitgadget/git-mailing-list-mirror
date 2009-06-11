From: E R <pc88mxer@gmail.com>
Subject: side-by-side diff for gitweb?
Date: Thu, 11 Jun 2009 14:41:38 -0500
Message-ID: <3a69fa7c0906111241w3d105003xecb44125822ac501@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 21:48:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEqGF-0005CT-Sv
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 21:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856AbZFKTsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 15:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbZFKTsW
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 15:48:22 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:39326 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbZFKTsV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 15:48:21 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1150803qwd.37
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=g1LagPDLRL7SVYcDTTZTGRArN7Ezzx9R09YvINgsKx0=;
        b=lS/QVp/f5QtpMRiEypWlFKLf56gIWffSZwRY9+5DGo2NHmkpuhHlkvHko9A6Qhxjl1
         6i2m9bkRBYXLBCuLdDlwP0Py/3hNQQHNddgONfJUYNGnA3Fg79nL85AhIaqcQRIYn0kk
         IUkfCVuuD0Hy7YqobzHdAZkglb5JMiYc3J2kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=UA1e9UPCrfygxxXK45hwQDb082AyzgtVLI6XDTB27KSSuORr0fhv6r6hh7aPm/q47R
         yEXaRigdkwpuzlMuZbYT46SeqKMypD8Cd1yuUwSMqaDKco9XoRU3IGkilsnPWILZyyCR
         m9IZ9rgFhXkQ/+41ODsYGpqNkAgIRiuH4hPGU=
Received: by 10.220.72.78 with SMTP id l14mr2634877vcj.81.1244749298300; Thu, 
	11 Jun 2009 12:41:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121356>

Is there a a side-by-side diff viewer for gitweb?

If not, any suggestions for the best way to go about implementing one?

Thanks,
ER
