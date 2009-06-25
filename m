From: Tim Visher <tim.visher@gmail.com>
Subject: Displaying Current Git Aliases
Date: Thu, 25 Jun 2009 11:59:38 -0400
Message-ID: <c115fd3c0906250859q661d2319i463d6eea7e9dbe54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 25 18:00:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJrMz-00083k-7L
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 18:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbZFYP7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 11:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753070AbZFYP7g
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 11:59:36 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:61291 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbZFYP7g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 11:59:36 -0400
Received: by an-out-0708.google.com with SMTP id d11so55569and.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 08:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=F1owLs0RTYrxy3q1PdI4QOAmS42GrpJId2UoGPh+szM=;
        b=NalyxBMDB4cUOyiRExMjDy/04NqL/XSg2QM0RJI1Fo79CQ8w6USOtTd8QFl/f7vIB2
         kFjB+Tzj+iQru9Urz5lX2GBIRI+MdpvRVeX7FRnByXZKZ3yrf8cS9RNGEiunRtu5YyxU
         cbdEWrl0d5WetqbFi76Kvgygq+P8te5gS/igQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=WJ2a8gvuxhxxD/kiEXfUSG7WJFXWODnTcip1d6Kiz1RdDnwKdeSqBuq3qwjjV54x5T
         NZ/v+VlUxi5/2Q2zLkEz8MTXCCgAgQ8AV1Z/ZtzbFeZDt2OtGYhMHzKIpqE/TuNjWKix
         X7EGLZ0CwIxD596zdTXziS6s4paB9cba7n/aM=
Received: by 10.100.95.11 with SMTP id s11mr3489901anb.118.1245945578802; Thu, 
	25 Jun 2009 08:59:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122215>

Can git display a list of all of your current aliases like bash's
`alias` command?

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
