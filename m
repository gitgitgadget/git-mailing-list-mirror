From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 00/11] More consistant terminology ("remote-tracking branch", "not updated")
Date: Sat, 23 Oct 2010 11:55:35 -0700 (PDT)
Message-ID: <m3fwvwkadi.fsf@localhost.localdomain>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Oct 23 20:55:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9jFp-0001oT-BD
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 20:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758253Ab0JWSzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 14:55:40 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52440 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758211Ab0JWSzj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 14:55:39 -0400
Received: by bwz11 with SMTP id 11so1391530bwz.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 11:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=89gbnDYsVW7dcTE2XGkfmTVFXPAn0BYOb7Tphl7Ar6I=;
        b=XQJMjCn24cXSoCQ9iHaaBGyiGW0y4Hat3EDXLcgFOfyB34fRovyX9dOaE9eEBy7P7m
         agJG21CuHgO/7gTUY1JsU701WdSGIlpgQ2Msq02H1tR2DU0J0p6tlm6g/dVpP/pShBq8
         9N3qXgl5haAEr6WrpjUos10/pj+UfEZ68RFsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Xb9QQQC0wxnru9A13FhZTzpTfAOQGIt5qNZBSe36fc0IYV2O52Qp4FflOxrihJRg+T
         4gWoySIW0ae2Sp4zYOvgXkx54khr+WWm8E3Ewv/WVF2MgBzZPqlfAxQ/K2ww8oZTeLCv
         e3p2Ph2+jB5petHM+ohlla2G6ae+EWOpOsq+o=
Received: by 10.204.62.209 with SMTP id y17mr3489331bkh.88.1287860136793;
        Sat, 23 Oct 2010 11:55:36 -0700 (PDT)
Received: from localhost.localdomain (abvr155.neoplus.adsl.tpnet.pl [83.8.215.155])
        by mx.google.com with ESMTPS id u4sm3223343bkz.17.2010.10.23.11.55.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Oct 2010 11:55:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9NIt5xL023885;
	Sat, 23 Oct 2010 20:55:15 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9NIsos9023876;
	Sat, 23 Oct 2010 20:54:50 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159814>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Following the discussion in
> 
> http://thread.gmane.org/gmane.comp.version-control.git/159287/
> http://thread.gmane.org/gmane.comp.version-control.git/159287/focus=159288
> 
> this is an attempt to be more consistant in the terminology used in Git.

Thank you very much for your work!

-- 
Jakub Narebski
Poland
ShadeHawk on #git
