From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 00:05:35 -0400
Message-ID: <45384B0F.4040901@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	
	<45357CC3.4040507@utoronto.ca>	
	<Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>	
	<4536EC93.9050305@utoronto.ca>	
	<845b6e870610190002u420118b8ud634bb9594572c48@mail.gmail.com>	
	<46d6db660610190149x32442596we4112cdd044185a@mail.gmail.com>	
	<45373E27.3050209@op5.se> <vpqwt6wsmb5.fsf@ecrins.imag.fr>	
	<72877ab10610190757u3d2b4df0o204c6ffd73af69b4@mail.gmail.com>	
	<45379A02.1010105@utoronto.ca>
	<72877ab10610192014o3a7f66c6v79f94f48615e08f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christian MICHON <christian.michon@gmail.com>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 06:06:16 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gale6-0004sx-2h
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 06:06:10 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Galdj-0006xG-Aa; Fri, 20 Oct 2006 05:05:47 +0100
Received: from server4.panoramicfeedback.com ([66.216.124.41])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <aaron.bentley@utoronto.ca>) id 1Galdh-0006x4-3K
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 05:05:45 +0100
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GaldZ-0000Ra-00; Fri, 20 Oct 2006 00:05:38 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Tim Webster <tdwebste@gmail.com>
In-Reply-To: <72877ab10610192014o3a7f66c6v79f94f48615e08f4@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29408>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tim Webster wrote:
> On 10/19/06, Aaron Bentley <aaron.bentley@utoronto.ca> wrote:
>> I believe SVN supports recording arbitrary file properties, so it's just
>> a matter of applying those properties to the tree.
> 
> yes svn has arbitrary properties which can be manipulated.
> They are not really intended for permissions, ownership, and acl.
> To use the svn properties for this requires adding scm tools.

Agreed.  I think it's okay to require extra work to set the scm up to
handle configurations.

> Also svn does not allow files in the same directory to live in
> multiple repos

It would surprise me if many SCMs that support atomic commit also
support intermixing files from multiple repos in the same directory.

>> You mean multiple merge sources?
> 
> yes, Multiple merge sources is handy for collaborative document editing

That's something I'd like for software development, too.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFOEsO0F+nu1YWqI0RAo+6AJ9lzF0+O1I8rgkyCOdhsir1gjo0NQCfXEVV
EIsDmS+eR/7cHKQfmnPJRA4=
=g5jk
-----END PGP SIGNATURE-----
