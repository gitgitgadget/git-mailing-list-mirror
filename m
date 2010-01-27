From: Weiwei Shu <shuww1980@gmail.com>
Subject: How to email out commit message automatically?
Date: Wed, 27 Jan 2010 11:20:46 -0500
Message-ID: <65d12cb11001270820i7094001odc4d9f27b7f57767@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, shuww2008@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 27 17:20:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaAdS-0003Ak-Rj
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 17:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303Ab0A0QUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 11:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753727Ab0A0QUt
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 11:20:49 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:57429 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205Ab0A0QUs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 11:20:48 -0500
Received: by bwz19 with SMTP id 19so4838391bwz.28
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 08:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=F2sPKILYkXAJZclG+KxsW0KxaLfIhfA3hkJdvQTN6AI=;
        b=DqPT/e8C0P/VFMoQ3ypJPEQkX22Q/RNFa//MEPy5LVC43hL6QrEmS8ClGVO17Sc9sF
         zKqzRUaPLSuhywOIq9T3OJxAv4Uue7DrPd4qX4pohuT1R8AqfOF/sut3u9zsqeaifXGL
         dok1JkW2QNRVcSMjwzgi2cViEn6AxacvMVdTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=jeXwZxU7ul3pRyWsQalZyt4jEd6MZAhDBZ3a8nRgx3EU1KLfh0j+RQjNGW/UCFo3Oz
         xnBevB9VNtY022rzf8pg2tEmxKA7Tu7FbNRmaay/xsd5NzXzzYT+zbwMiVUb6Q2Vt23u
         NA1Ubi3vJMlpZAtme1JTSshjkcZXT+bPLCB48=
Received: by 10.204.9.151 with SMTP id l23mr2899849bkl.76.1264609246605; Wed, 
	27 Jan 2010 08:20:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138166>

Hi All,

The second time to post here.  Git is great.

I would like to email the commit message to my Gmail box automatically
whenever I submit a commit.  Can anybody point me a link on how to do
that?  I've searched it for half day but not successful.  Thanks!


Weiwei
