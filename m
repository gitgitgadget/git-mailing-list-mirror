From: Tim Visher <tim.visher@gmail.com>
Subject: Altering Previous Commits' Author Field.
Date: Tue, 24 Feb 2009 16:29:15 -0500
Message-ID: <c115fd3c0902241329i2455bc8bj62ec41856773be30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 22:31:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc4rz-0000oy-IA
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 22:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbZBXV3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 16:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753895AbZBXV3T
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 16:29:19 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:59644 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbZBXV3S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 16:29:18 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1174353ywh.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 13:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=54udNRIHhMihzRJjH+B0qSnB9Il2NjQXCcvhBpVGZK8=;
        b=GNLJvEiwXLZQjIxxGvi5HPNGDbstmfdHcrD85SgpSFcUufF6IxH1Ubf4g3c7OsVQCF
         q1unF75JdrUf95pNJnhkpBIV8VadM57WvRjcznc2pDAKDM/40E47AXxdxLuJQZ4xsRjg
         afEkD9OSrMP8aHBplTB4lfnDwkGkhUo1h6uBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=REvdVRcOZ6tA+ynXGczAuieQeoNYlbjcxz43H4HOg0nsrbZcf6j6eCHGViSEw9qTf0
         IyzLgRbRz0iP9IztEUuSSWCRGIqO2JTlH7xubnK4FrKdIgymR4JLu7lX4TBzT189kuqu
         QJOWaqkHkAdgRh+BIrv0tdUg8k5ybxFYKGRAw=
Received: by 10.101.68.19 with SMTP id v19mr179508ank.58.1235510955970; Tue, 
	24 Feb 2009 13:29:15 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111345>

Hello Everyone,

I have two identities that git knows me as, one for personal and the
other for work.  I just realized that I project I've been doing some
work on at work was using the global config file on that box because I
had forgotten to a project specific config to change my identity.  Is
there any way for me to edit the history so that the Author of all of
those commits is changed to my personal identity?

Thanks in advance!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
