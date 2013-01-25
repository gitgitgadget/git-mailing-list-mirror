From: Mario Michael Krell <supermariton@googlemail.com>
Subject: git-core vs git package on ubuntu
Date: Fri, 25 Jan 2013 14:50:24 +0100
Message-ID: <4A4C2896-042A-4BE3-9E74-012D881D5776@googlemail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 14:51:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyjgG-000731-49
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 14:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757330Ab3AYNub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 08:50:31 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47164 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757219Ab3AYNu3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2013 08:50:29 -0500
Received: by mail-bk0-f46.google.com with SMTP id j5so254850bkw.5
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 05:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=x-received:from:content-type:content-transfer-encoding:subject:date
         :message-id:to:mime-version:x-mailer;
        bh=nLSFjAWg8aZffD3nNTXibEqawGB8JTfjtdqlXhVXHK4=;
        b=lNPeS5VwOq3r7I7AUQG4a0uMa+lTQU9JJwOn5iHrxqvIDbeyhFFLZreCa9zqRiTaFr
         HIX3j9GmkjFVarhlnFlLfkC1Tc7StrFOwcY19bh+MPEkdueBCeJM7+dmQPFno5xKoKSx
         dkKuxJQ9ReL6npJgXQE9pxQVRz2HfwO/YzRUnGoOV2qcwglGiZrlRPghy5+X10M9mmjN
         wziRFgJ5qUzwfSavDSKTclMLXd2Uo6xqzz6BQBD8xHcS3eIywNe4zBypXv/82vRiruj/
         R9LnKDwBJnHzouy41cWpEkoQ53gXwVrF+onfijlHHvO/gC4zlYgm548wKDzPIx3C7WsK
         pmgQ==
X-Received: by 10.204.149.11 with SMTP id r11mr1813132bkv.93.1359121827942;
        Fri, 25 Jan 2013 05:50:27 -0800 (PST)
Received: from [192.168.114.63] (te52.informatik.uni-bremen.de. [134.102.219.52])
        by mx.google.com with ESMTPS id f24sm1152699bkw.4.2013.01.25.05.50.25
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 05:50:27 -0800 (PST)
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214551>


Dear git developers,

In your documentation you say, that git should be installed on Unix using

apt-get install git-core

Unfortunately it tells the user, that this package is obsolete and "git" should be used instead. Is this an error in the package manager or in the website documentation?

Greets

Mario