From: Javier Domingo <javierdo1@gmail.com>
Subject: Fwd: Git remote possible feature request
Date: Fri, 8 Feb 2013 16:30:52 +0100
Message-ID: <CALZVap=-aGi6zpbvDv5b98pRw7bUSTDUZsPnT0+D1HJZJpsuBA@mail.gmail.com>
References: <CALZVapkxbY_sQucxznTQ-SJ6-YkxZvFH2TDjRtfL8Qsai1ZsWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 16:31:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3pvO-00018n-DB
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 16:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946614Ab3BHPbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 10:31:15 -0500
Received: from mail-vc0-f175.google.com ([209.85.220.175]:36448 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946601Ab3BHPbO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 10:31:14 -0500
Received: by mail-vc0-f175.google.com with SMTP id fw7so2398972vcb.20
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 07:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:content-type;
        bh=NZFfvoJV7NxnKtwxG2vWWD7aJlnrrbqN9dsd3vmjBf8=;
        b=o4x5WEMwnZzqhH6T6FTGa/q/FBFok03cU60FlIn0IKMKbevP6hfHjDuy/UOAdnsS4K
         J/+tpkDw1+kgcU4qvtLyqAWOBvu9ER3EwhutefeVz3vWxLFecUwz5SMj5WBY10iM9fVD
         reawKendWFCUuu81CzPy+DU5d7KPDFSH5/cbMP3/Z+uNHmIcXFooko08/LPkY7mht7yg
         ZLReyYE1R38jEN3k3GLMX13CI69ySHLEAgELIE6zNLPOZv5ZmUV6cxgKbf8QwOfVoQoQ
         c01ApK8uGSVROZ76vmt2GMFOT6Gnp+zuTXtRb1dQsyXFIg6RVJZwN2gqGfUDYo2xUZTr
         4lSA==
X-Received: by 10.220.150.3 with SMTP id w3mr7054100vcv.37.1360337473993; Fri,
 08 Feb 2013 07:31:13 -0800 (PST)
Received: by 10.58.6.211 with HTTP; Fri, 8 Feb 2013 07:30:52 -0800 (PST)
In-Reply-To: <CALZVapkxbY_sQucxznTQ-SJ6-YkxZvFH2TDjRtfL8Qsai1ZsWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215776>

Hi,

Just wanted to check if that when you add a remote with
--mirror=fetch, it means that you just want to fetch from that mirror.

Would that avoid accidentally pushing to that mirror?

I would like to be able to mark some remotes as read-only...

Thank you,

Javier Domingo
