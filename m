From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: cvs -> git tools?
Date: Fri, 21 Dec 2007 14:07:29 -0800 (PST)
Message-ID: <m3ve6rog69.fsf@roke.D-201>
References: <476C1D9E.4060700@advancedsl.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?Gonzalo_Garramu=F1o?= <ggarra@advancedsl.com.ar>
X-From: git-owner@vger.kernel.org Fri Dec 21 23:07:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5q28-0004Y4-PK
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 23:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbXLUWHd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Dec 2007 17:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbXLUWHd
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 17:07:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:8877 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354AbXLUWHc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2007 17:07:32 -0500
Received: by ug-out-1314.google.com with SMTP id z38so690227ugc.16
        for <git@vger.kernel.org>; Fri, 21 Dec 2007 14:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        bh=Co0XclVi5bUY4QWPfjq68q/ftbFHqK0s755iHRSzjqo=;
        b=Grzhau/oKEHSpPnR4NHNLTQbmaVX1UdttczhRbjx+3k+aAUQCjnIDvpw2hdvinVU7Q96v/R61gV86TEYZoCIPBSrfFc7oDSnwng/jvGkGA2Sgd9dXdyEn1aOhxp+2FwgiO92T+blQP8m6+HwqEuY4MDC9R6LIdMgAhj5ltQHctM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        b=EV0PIodw7uNNsP9v6LkYOLfUiPCb0m4PO99jydP70R7jvm2Fky+sUq3YI0MxqMHvQfI122UPRVJizvr+PVWscCL0kMq3NYC98nExV4S/lLW2gl/X1CXrFLHzVp4H5db6VvupK8+CcD6EzVyakaZmy8sCxrBEuqiBZ6qCIVmHRyw=
Received: by 10.67.25.6 with SMTP id c6mr373495ugj.65.1198274851450;
        Fri, 21 Dec 2007 14:07:31 -0800 (PST)
Received: from roke.D-201 ( [83.8.189.110])
        by mx.google.com with ESMTPS id i40sm4067350ugf.4.2007.12.21.14.07.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Dec 2007 14:07:30 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBLM7Soa015652;
	Fri, 21 Dec 2007 23:07:28 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id lBLM7QEg015649;
	Fri, 21 Dec 2007 23:07:26 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <476C1D9E.4060700@advancedsl.com.ar>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69100>

Gonzalo Garramu=F1o <ggarra@advancedsl.com.ar> writes:

> Are there any good websites that can host a git repository?  Somethin=
g
> equivalent to sourceforge but for git.

Check out the end of the GitProjects page on GitWiki:
  http://git.or.cz/gitwiki/GitProjects

--=20
Jakub Narebski
Poland
ShadeHawk on #git
