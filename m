From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Stamp Git commit id into file during build process
Date: Sat, 16 Jan 2010 20:15:51 +0100
Message-ID: <40aa078e1001161115r312f2e7ahbe9bab6c28b3ad2e@mail.gmail.com>
References: <a1138db31001161050i73eade1bif968ca1256dcef2c@mail.gmail.com>
	 <40aa078e1001161114w5a65bebbhaf43317634899925@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Paul Richards <paul.richards@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 20:16:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWE7p-0003ot-GH
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 20:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948Ab0APTPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 14:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755924Ab0APTPy
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 14:15:54 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:43239 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab0APTPx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 14:15:53 -0500
Received: by ewy19 with SMTP id 19so1955702ewy.21
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 11:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=TRM97/FLMgrvf6ZPJxjcwGj+8wWumuWX+Dkr18xGS7k=;
        b=BAUcopV4QF4XQ2RxNgBEPYt1GuEh+GKdhPv5YeSVQfVhd4w6lT5LBcKnFnda8dxxdX
         P/PQsrIS+X6abJsG2AdzB495v64j6abLAkSTTVr4mylHiizyLLNLHrntbB34AsLOEl1p
         dkvPckFtew2fTVpAF9KEHCIOZKhc8ug/u6GW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=OjEzAIrgpsXIb+m/d6CUTcTPKo7Utq3k+NBbYFgfPhosuaSa+h9uTvIL/5pzSNbV+J
         NfwV3gk99gALWAScdYB1GhIt6WX7NLD0E0qeI6vollYCJlla933s+RKqFUQocW006gaX
         x/LPN3Wyray79k25zh4eZeC+cMGGV//AMLlwk=
Received: by 10.216.86.11 with SMTP id v11mr1393855wee.220.1263669351839; Sat, 
	16 Jan 2010 11:15:51 -0800 (PST)
In-Reply-To: <40aa078e1001161114w5a65bebbhaf43317634899925@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137252>

On Sat, Jan 16, 2010 at 8:14 PM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> the "git describe"-tool, which gives a nice and short description of
> the commit relative to the most recent commit.
>

...by "most recent commit", I mean "most recent tag". Sorry about that.


-- 
Erik "kusma" Faye-Lund
