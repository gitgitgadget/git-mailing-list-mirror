From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [ANNOUNCE] cgit v0.7
Date: Tue, 6 Nov 2007 00:53:41 +0100
Message-ID: <8c5c35580711051553w6dbb542ao925d11c0bff33e9b@mail.gmail.com>
References: <8c5c35580711030408n658eb11fk19d554f0fa3b17@mail.gmail.com>
	 <1194222569-13948-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 00:54:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpBlV-000514-3m
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 00:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbXKEXxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 18:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754631AbXKEXxm
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 18:53:42 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:58318 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574AbXKEXxl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 18:53:41 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2199647wah
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 15:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xHyhBADVZlpNUuJxZmyhUzZKF43ncXJdp/AgVx1r3ic=;
        b=Qm7QQDbPISJ4amisW4vivQV9vADFHWMhDUY3BMrRtydhy9GeeNWTY/l0SECn1TsXbRtUG7RmPQzYk9zrm3kaT8yZLJNwfm8H3WCmqVnH8AXx6Ht3RLCXhuNf0PEkakwabj7SGm97fX/gDjNzpqQCvACxIAgdZAFo5LjvPIdBaTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EeCdFG3tyopQcOInq5TEijhIAHOUI7Gws/PnScLpMLZvMKzMxrirNoAbg4CsHHFGf+ngPxTUrqqElpzPyirYY4KLvvqfLdkqfEEZ5J+awweDI3l4rmAAgpya2FrkrgVJ86SFOCuhOUelC3oaCdJsICgNM/hw4fH7BfgL42d3WPk=
Received: by 10.114.109.1 with SMTP id h1mr5769984wac.1194306821257;
        Mon, 05 Nov 2007 15:53:41 -0800 (PST)
Received: by 10.114.235.4 with HTTP; Mon, 5 Nov 2007 15:53:41 -0800 (PST)
In-Reply-To: <1194222569-13948-1-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63593>

On Nov 5, 2007 1:29 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>  * I'm not sure if it wouln't be beter to provide -n/+m lines changed
>    instead of nn likes changed column.

Agreed, and fixed.

--
larsh
