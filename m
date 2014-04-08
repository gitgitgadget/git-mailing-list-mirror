From: Junio C Hamano <gitster@pobox.com>
Subject: Our official home page and logo for the Git project
Date: Tue, 08 Apr 2014 11:44:12 -0700
Message-ID: <xmqq7g6z4q6b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 20:44:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXb0T-0003p4-QF
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 20:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757643AbaDHSoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 14:44:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41980 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756839AbaDHSoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 14:44:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D30D79576;
	Tue,  8 Apr 2014 14:44:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=U
	npdSOFBK5ae7fEEkVOXBgUwbhI=; b=ns3NRyg+Hazp6T5c1Bde8wXGx2Xq6m8Mj
	j0JxurMPu1QcyeYNznWBnAsMdS7BtTALW15Cx7cx0jkLJGI1yBcvxfSoH9iC5SeT
	98ZqeJgGZxKEmODKCC+QwAI90w/cIXXW03thxaJrm/eNbPIm7mOrEMvQk3oZLzDV
	n+9Ox/QCQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=t+b
	QVmdVaWY3adKLgsC/TbhTDJgcuLINcpco6HcaCSParZwpHpNeLm6lAngj4de73If
	3KGPSEdG/1gyCtXDn5OZLINPYWW6Kw3cpevONtKa76EiCtx7qaZNIlaJAyzn6vEJ
	NoP5ID3jICDVmuify9ZCBh1b7EZDj2z7RUmg+b1Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A8B679571;
	Tue,  8 Apr 2014 14:44:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BF0E7956F;
	Tue,  8 Apr 2014 14:44:13 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C80830A8-BF4D-11E3-97C1-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245945>

Recently, somebody approached Software Freedom Conservancy,
wishing to obtain our blessing for using the Git logo on some
trinket they are planning to make.  We joined Conservancy
earlier, primarily so that we have a legal entity that can
receive and pool the GSoC mentor stipend, and because we are now
one of Conservancy's projects, it was understandable that they
were approached for this request.

However, while we've been using the logo created by Jason Long
as our de facto logo (and git-scm.com as the de facto Git home
page), we've yet to formally adopt Jason's logo (or any logo) as
an "official" Git logo [*1*].

So, to clarify things -- and to make it easier to respond to
requests re: our logo in the future, we (myself, Peff and Shawn,
the troika who represent the Git community to Conservancy)
propose the following to the community members:

 - To officially adopt "git-scm.com <http://git-scm.com>" (and
   "git-scm.org <http://git-scm.org>") as our "project home
   page"; and

 - To officially adopt the logo that appears on the "project
   home page" as our "project logo".

We hope that neither is controversial, as these have long been
used to represent our project without any formal declaration of
them being official, and this proposal is to ask the community
members to acknowledge the status quo ex post facto [*2*].

Seconds?

[Footnotes]

*1* We already got an OK from Jason for use of the logo as an
official project logo.

*2* This doesn't imply any change in how things are run
day-to-day.  The source changes are discussed on this list, and
updated codebase will be pushed to the usual repositories
including git://git.kernel.org/pub/scm/git/git.git/.  Scott
Chacon will continue to maintain the git-scm.com site, as he
always has done, and if you have suggestions or fixes for the
site, you can send pull requests.
